import 'dart:io';

import 'package:flutter_clean_architecture_tdd_weatherapp/data/datasource/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/exception.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
