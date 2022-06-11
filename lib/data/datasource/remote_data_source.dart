import 'dart:convert';

import 'package:flutter_clean_architecture_tdd_weatherapp/data/constants.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/exception.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String tCityName);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  const RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
