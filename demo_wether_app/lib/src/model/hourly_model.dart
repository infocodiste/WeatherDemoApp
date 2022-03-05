// To parse this JSON data, do
//
//     final hourlyData = hourlyDataFromJson(jsonString);

import 'dart:convert';

HourlyData hourlyDataFromJson(String str) => HourlyData.fromJson(json.decode(str));

String hourlyDataToJson(HourlyData data) => json.encode(data.toJson());

class HourlyData {
  HourlyData({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
  });

  double? lat,lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;
  List<Current>? hourly;

  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    current: json["current"] == null ? null : Current.fromJson(json["current"]),
    hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "current": current!.toJson(),
    "hourly": List<dynamic>.from(hourly!.map((x) => x.toJson())),
  };
}

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.windGust,
    this.pop,
  });

  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<Weather>? weather;
  double? windGust;
  var pop;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json["dt"],
    sunrise: json["sunrise"] == null ? null : json["sunrise"],
    sunset: json["sunset"] == null ? null : json["sunset"],
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"].toDouble(),
    uvi: json["uvi"].toDouble(),
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"],
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    windGust: json["wind_gust"] == null ? null : json["wind_gust"].toDouble(),
    pop: json["pop"] == null ? null : json["pop"],
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise == null ? null : sunrise,
    "sunset": sunset == null ? null : sunset,
    "temp": temp,
    "feels_like": feelsLike,
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "uvi": uvi,
    "clouds": clouds,
    "visibility": visibility,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
    "wind_gust": windGust == null ? null : windGust,
    "pop": pop == null ? null : pop,
  };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

// enum Description { CLEAR_SKY, FEW_CLOUDS, SCATTERED_CLOUDS, BROKEN_CLOUDS, OVERCAST_CLOUDS }

// final descriptionValues = EnumValues({
//   "broken clouds": Description.BROKEN_CLOUDS,
//   "clear sky": Description.CLEAR_SKY,
//   "few clouds": Description.FEW_CLOUDS,
//   "overcast clouds": Description.OVERCAST_CLOUDS,
//   "scattered clouds": Description.SCATTERED_CLOUDS
// });

// enum Main { CLEAR, CLOUDS }
//
// final mainValues = EnumValues({
//   "Clear": Main.CLEAR,
//   "Clouds": Main.CLOUDS
// });
//
// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String>? get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
