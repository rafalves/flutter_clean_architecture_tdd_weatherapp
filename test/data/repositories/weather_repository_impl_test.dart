import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/datasource/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/exception.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/models/weather_model.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

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

  group('get current weather', () {
    const tCityName = 'São Paulo';

    test(
        'should return current weather when a call to data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getCurrentWeather(tCityName))
          .thenAnswer((_) async => tWeatherModel);

      // act
      final result = await repository.getCurrentWeather(tCityName);

      // assert
      verify(() => mockRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, equals(const Right(tWeather)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getCurrentWeather(tCityName))
          .thenThrow(ServerException());

      // act
      final result = await repository.getCurrentWeather(tCityName);

      //assert
      verify(() => mockRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getCurrentWeather(tCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));
    });
  });
}
