import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String name);
}
