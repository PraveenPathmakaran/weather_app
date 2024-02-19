// instance for getting the api response
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather.dart';

class CurrentEntity extends Equatable {
  final int temp;
  final int humidity;
  final int clouds;
  final double uvIndex;
  final double feelsLike;
  final double windSpeed;
  final List<WeatherEntity> weather;

  const CurrentEntity({
    required this.temp,
    required this.humidity,
    required this.feelsLike,
    required this.clouds,
    required this.uvIndex,
    required this.windSpeed,
    required this.weather,
  });

  static CurrentEntity emptyCurrentEntity() {
    return const CurrentEntity(
      temp: 0,
      humidity: 0,
      feelsLike: 0,
      clouds: 0,
      uvIndex: 0,
      windSpeed: 0,
      weather: [],
    );
  }

  @override
  List<Object?> get props =>
      [temp, feelsLike, uvIndex, humidity, clouds, windSpeed, weather];
}
