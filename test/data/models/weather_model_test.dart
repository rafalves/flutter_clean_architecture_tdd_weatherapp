import 'dart:convert';

import 'package:flutter_clean_architecture_tdd_weatherapp/data/models/weather_model.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'São Paulo',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 17.19,
    humidity: 93,
  );

  const tWeather = Weather(
    cityName: 'São Paulo',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 17.19,
    humidity: 93,
  );

  group('to entity', () {
    test('should be a subclass of weather entity', () async {
      // assert
      final result = tWeatherModel.toEntity();
      expect(result, equals(tWeather));
    });
  });

  group('from json', () {
    test('should return a valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_weather_response.json'),
      );
      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result, equals(tWeatherModel));
    });
  });

  group('to json', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04d',
          }
        ],
        'main': {
          'temp': 17.19,
          'humidity': 93,
        },
        'name': 'São Paulo',
      };
      expect(result, equals(expectedJsonMap));
    });
  });
}
