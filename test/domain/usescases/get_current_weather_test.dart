import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/repositories/weather_repository.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(repository: mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'São Paulo',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 17.19,
    humidity: 93,
  );

  const tCityName = 'São Paulo';

  test('should get current weather detail from repository', () async {
    // arrange
    when(() => mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async => (const Right(testWeatherDetail)));

    // act
    final result = await usecase(tCityName);

    // assert
    expect(result, equals(const Right(testWeatherDetail)));
  });
}
