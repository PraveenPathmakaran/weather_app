// instance for getting the api response
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_current.dart';

import 'weather.dart';

class CurrentModel extends Equatable {
  final int? temp;
  final int? humidity;
  final int? clouds;
  final double? uvIndex;
  final double? feelsLike;
  final double? windSpeed;
  final List<WeatherModel>? weather;

  const CurrentModel({
    this.temp,
    this.humidity,
    this.feelsLike,
    this.clouds,
    this.uvIndex,
    this.windSpeed,
    this.weather,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        temp: (json['temp'] as num?)?.round(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        uvIndex: (json['uvi'] as num?)?.toDouble(),
        clouds: json['clouds'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'uvi': uvIndex,
        'humidity': humidity,
        'clouds': clouds,
        'wind_speed': windSpeed,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };

  CurrentEntity toDomain() {
    return CurrentEntity(
      temp: temp ?? 0,
      humidity: humidity ?? 0,
      feelsLike: feelsLike ?? 0,
      clouds: clouds ?? 0,
      uvIndex: uvIndex ?? 0,
      windSpeed: windSpeed ?? 0,
      weather: weather?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props =>
      [temp, feelsLike, uvIndex, humidity, clouds, windSpeed, weather];
}
