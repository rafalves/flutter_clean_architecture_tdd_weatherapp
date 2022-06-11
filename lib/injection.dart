import 'package:flutter_clean_architecture_tdd_weatherapp/data/datasource/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/repositories/weather_repository.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/usecases/get_current_weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(repository: locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDataSource: locator()));

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: http.Client()));
}
