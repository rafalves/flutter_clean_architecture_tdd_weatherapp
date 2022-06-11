import 'dart:convert';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/constants.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/datasource/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_clean_architecture_tdd_weatherapp/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/json_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current weather', () {
    const tCityName = 'São Paulo';
    final tWeatherModel = WeatherModel.fromJson(
        json.decode(readJson('helpers/dummy_weather_response.json')));

    test('should return weather model when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(tCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_weather_response.json'), 200));

      // act
      final result = await dataSource.getCurrentWeather(tCityName);

      // assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(tCityName))))
          .thenAnswer((invocation) async => http.Response('Not found', 404));
      // act
      final call = dataSource.getCurrentWeather(tCityName);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
