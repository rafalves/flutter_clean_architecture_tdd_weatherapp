import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/data/failure.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/usecases/get_current_weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_bloc.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_event.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  const tWeather = Weather(
    cityName: 'São Paulo',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 17.19,
    humidity: 93,
  );

  const tCityName = 'São Paulo';

  test('initial state should be empty', () async {
    // assert
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [loading, has data] when data is gotten successfuly',
    build: () {
      when(() => mockGetCurrentWeather(tCityName))
          .thenAnswer((_) async => const Right(tWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCityName)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WeatherLoading(),
      const WeatherHasData(tWeather),
    ],
    verify: (bloc) {
      verify(() => mockGetCurrentWeather(tCityName));
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [loading, error] when get data is unsuccessful',
    build: () {
      when(() => mockGetCurrentWeather(tCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCityName)),
    expect: () => [
      WeatherLoading(),
      const WeatherError('Server failure'),
    ],
    verify: (bloc) => verify(() => mockGetCurrentWeather(tCityName)),
  );
}
