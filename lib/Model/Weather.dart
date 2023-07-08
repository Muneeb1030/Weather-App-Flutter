import 'dart:convert';

import 'package:http/http.dart';

class WeatherInfo {
  late String _temperature;
  late String _humidity;
  late String _airSpeed;
  late String _description;
  late String _main;
  late String _icon;
  late String _location;

  WeatherInfo.empty();

  WeatherInfo({
    required String airSpeed,
    required String description,
    required String humidity,
    required String icon,
    required String main,
    required String temperature,
    required String location,
  }) {
    _airSpeed = airSpeed;
    _description = description;
    _humidity = humidity;
    _icon = icon;
    _main = main;
    _temperature = temperature;
    _location = location;
  }

  String get temperature => _temperature;

  set temperature(String temperature) {
    _temperature = temperature;
  }

  String get humidity => _humidity;

  set humidity(String humidity) {
    _humidity = humidity;
  }

  String get airSpeed => _airSpeed;

  set airSpeed(String airSpeed) {
    _airSpeed = airSpeed;
  }

  String get description => _description;

  set description(String description) {
    _description = description;
  }

  String get main => _main;

  set main(String main) {
    _main = main;
  }

  String get icon => _icon;

  set icon(String icon) {
    _icon = icon;
  }

  String get location => _location;

  set location(String location) {
    _location = location;
  }
  
  Future<WeatherInfo> getInfo(String City) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$City&appid=0f6264eac8aa1c023fdec21731b1f1d6"));
    Map data = jsonDecode(response.body);

    Map DataRequired = data['main'];

    String getHumidity = DataRequired['humidity'].toString();
    String getTemp = (DataRequired['temp'] - 273.15).toString();
    getTemp = getTemp.substring(0, 4);
    DataRequired = data['wind'];

    String getAir_speed =
        (DataRequired["speed"] / 0.27777777777778).toString().substring(0, 5);

    List weather_data = data['weather'];
    DataRequired = weather_data[0];

    String getMain_des = DataRequired['main'];
    String getDesc = DataRequired["description"];
    String getIcon = DataRequired["icon"].toString();

    return WeatherInfo(
        airSpeed: getAir_speed,
        description: getDesc,
        humidity: getHumidity,
        icon: getIcon,
        main: getMain_des,
        temperature: getTemp,
        location: City);
  }
}
