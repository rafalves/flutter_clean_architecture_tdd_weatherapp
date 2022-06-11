import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_tdd_weatherapp/domain/entities/weather.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int humidity;

  const WeatherModel({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        iconCode: json['weather'][0]['icon'],
        temperature: json['main']['temp'],
        humidity: json['main']['humidity'],
      );

  Map<String, dynamic> toJson() => {
        'weather': [
          {
            'main': main,
            'description': description,
            'icon': iconCode,
          }
        ],
        'main': {
          'temp': temperature,
          'humidity': humidity,
        },
        'name': cityName,
      };
  Weather toEntity() => Weather(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        humidity: humidity,
      );

  @override
  List<Object> get props {
    return [
      cityName,
      main,
      description,
      iconCode,
      temperature,
      humidity,
    ];
  }
}
