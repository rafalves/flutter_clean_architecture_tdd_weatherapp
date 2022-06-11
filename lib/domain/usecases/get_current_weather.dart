import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  const GetCurrentWeather({required this.repository});

  Future<Either<Failure, Weather>> call(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
