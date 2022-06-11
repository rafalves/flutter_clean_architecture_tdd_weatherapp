import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/usecases/get_current_weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_event.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;

  WeatherBloc(this._getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>(((event, emit) async {
      final cityName = event.cityName;

      emit(WeatherLoading());

      final result = await _getCurrentWeather(cityName);
      result.fold((failure) {
        emit(WeatherError(failure.message));
      }, (data) {
        emit(WeatherHasData(data));
      });
    }));
  }
}
