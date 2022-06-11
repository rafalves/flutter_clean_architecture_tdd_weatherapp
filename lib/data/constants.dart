import 'package:flutter_clean_architecture_tdd_weatherapp/api_key.dart';

class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  // get your free key at OpenWeather website, mine was .gitignored
  static const String apiKey = put_your_api_key_here;
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&units=metric&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
