import 'package:demo_wether_app/src/api/api_repository.dart';
import 'package:demo_wether_app/src/model/current_weather_data.dart';
import 'package:demo_wether_app/src/model/five_days_data.dart';
import 'package:demo_wether_app/src/model/hourly_model.dart';
import 'package:flutter/foundation.dart';
class WeatherService {
  final String? city;
  var latitude,longitude;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=61fc8f2fbdf28deb396db828a62a1641';

  WeatherService({this.city,this.longitude,this.latitude});

// this function will give data of Current weather data of selected location
  void getCurrentWeatherData({
    required Function() beforSend,
    required Function(CurrentWeatherData currentWeatherData) onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    ApiRepository(url: url, payload: null).get(
      beforeSend: () => {
        if (beforSend != null){
          beforSend(),
        },
      },
      onSuccess: (data) => {
        onSuccess(CurrentWeatherData.fromJson(data)),
      },
      onError: (error) => {
        if (onError != null)
          {
            debugPrint('getCurrentWeatherData => ERROR : $error'),
            onError(error),
          }
      });
  }

// this function will give data of next five days forecast
  void getFiveDaysThreeHoursForcastData({
    required Function() beforSend,
    required Function(List<FiveDayData> fiveDayData) onSuccess,
    required Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    print(url);
    ApiRepository(url: url, payload: null).get(
        beforeSend: () => {},
        onSuccess: (data) => {
              onSuccess((data['list'] as List)
                      .map((t) => FiveDayData.fromJson(t))
                      .toList()),
            },
        onError: (error) => {
              print(error),
              onError(error),
            });
  }

// this function will give data of every 48 hour forecast for selected location
  Future getHourlyForecastData({
    required Function() beforSend,
    required Function(HourlyData fiveDayData) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final url = '$baseUrl/onecall?lat=$latitude&lon=$longitude&exclude=minutely,daily&$apiKey';
    debugPrint('getHourlyForecastData => url : $url');
    ApiRepository(url: url, payload: null).get(
        beforeSend: () => {},
        onSuccess: (data) => {
        debugPrint('getHourlyForecastData => data : $data'),
          onSuccess(HourlyData.fromJson(data)),
        },
        onError: (error) => {
          debugPrint('getHourlyForecastData => ERROR : $error'),
          onError(error),
        });
  }
}
