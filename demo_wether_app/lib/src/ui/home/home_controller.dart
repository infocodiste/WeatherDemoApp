import 'dart:async';
import 'package:demo_wether_app/src/Const/app_constant.dart';
import 'package:demo_wether_app/src/Const/app_image.dart';
import 'package:demo_wether_app/src/Widget/progress_dialog_utils.dart';
import 'package:demo_wether_app/src/model/current_weather_data.dart';
import 'package:demo_wether_app/src/model/five_days_data.dart';
import 'package:demo_wether_app/src/model/hourly_model.dart';
import 'package:demo_wether_app/src/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  var latitude, longitude;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];


  Rx<HourlyData> hourlyData = HourlyData().obs;

  RxString currentCityImage = Assets.imgBrokenCloud.obs;

  @override
  void onInit() {
    currentLocation();
    if (hourlyData.value.current != null) currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
    getTopFiveCities();
    super.onInit();
  }
// returns city name from Lat Lang
  Future getLatLong() async {
    await locationFromAddress(city!).then((coordinates) {
      latitude = coordinates[0].latitude;
      longitude = coordinates[0].longitude;
      getHourlyData();
    }).onError((error, stackTrace) {
      city = null;
      debugPrint("getLatLong => ERROR : $error");
    });
    return city;
  }
  @override
  void onReady() {

    // TODO: implement onReady
    if (hourlyData.value.current != null) currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
    super.onReady();
  }
// Get current Lat Lang
  void currentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        debugPrint('location: ${position.latitude}');
        getAddress(position.latitude, position.longitude).then((value) async {
          debugPrint("Value ====> $value");
          city = value;
          getLatLong();
          getCurrentWeatherData();
          getFiveDaysData();
          if (hourlyData.value.current != null) currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
        });
  }

// Getting address from Lat Lang
  Future<String> getAddress(double lat, double lang) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
    var first = placemarks.first;
    String city = first.locality.toString();
    debugPrint("City ======> $city");
    return city;
  }
// Update Weather Data
  void updateWeather() {
    debugPrint("City ======> $city");
    if (hourlyData.value.current != null) {
      currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
    }
    getLatLong().then((cityValue) {
      debugPrint('updateWeather => cityValue : $cityValue');
      if(cityValue != null) {
        getCurrentWeatherData();
        getFiveDaysData();
        getHourlyData();
        if (hourlyData.value.current != null) currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
      }
      else{
        Const().toast('City not found.');
      }

    });
    update();
  }


   String imageSett(var st) {
    debugPrint("St ----- " + st);
    String img = "";
    switch (st) {
      case "Thunderstorm":
        img = Assets.imgThunderstorm;
        break;
      case "Drizzle":
        img = Assets.imgShowerRain;
        break;
      case "Rain":
        img = Assets.imgRain;
        break;
      case "Snow":
        img = Assets.imgSnow;
        break;
      case "Clear":
        img = Assets.imgClearSky;
        break;
      case "Clouds":
        img = Assets.imgScatteredClouds;
        break;
      default:
        img = Assets.imgMist;
    }
    debugPrint("current ====== " + img);
    return img;
  }

// Set Current Weather Data
  void getCurrentWeatherData() {
    if(city != null) {
      WeatherService(city: '$city').getCurrentWeatherData(
          onSuccess: (data) {
            currentWeatherData = data;
            currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
            update();
          },
          onError: (error) => {
            print(error),
            update(),
          },
          beforSend: () {});
    }

  }

// set Data for top Five City
  void getTopFiveCities() {
    List<String> cities = ['London', 'New York', 'Paris', 'Moscow', 'Tokyo'];
    cities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(
        onSuccess: (data) {
          dataList.add(data);
          update();
        },
        onError: (error) {
          print(error);
          update();
        },
        beforSend: () {});
    });
  }

//set data for 5 days
  void getFiveDaysData() {
    if(city != null) {
      WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
          onSuccess: (data) {
            fiveDaysData.clear();
            fiveDaysData = data;
            update();
          },
          onError: (error) {
            print(error);
            update();
          },
          beforSend: () {});
    }

  }

// get hourly data
  void getHourlyData() {
    debugPrint('city : $city');
    if(city != null) {
      WeatherService(latitude: latitude,longitude: longitude).getHourlyForecastData(
        onSuccess: (data) {
          hourlyData.value = data;
          if (hourlyData.value.current != null) currentCityImage.value = imageSett(hourlyData.value.current!.weather![0].main);
          update();
        },
        onError: (error) {
          debugPrint('getHourlyData => ERROR : $error');
          update();
        },
        beforSend: () {
          debugPrint('getHourlyData => hourlyData beforSend : $hourlyData');
        });
    }
  }
}
