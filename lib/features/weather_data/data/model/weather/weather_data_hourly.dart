import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_hourly.dart';

import 'weather.dart';

class HourlyModel extends Equatable {
  final int? dt;
  final int? temp;
  final List<WeatherModel>? weather;

  const HourlyModel({
    this.dt,
    this.temp,
    this.weather,
  });

  factory HourlyModel.fromJson(Map<String, dynamic> json) => HourlyModel(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.round(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };

  HourlyEntity toDomain() {
    return HourlyEntity(
      dt: dt ?? 0,
      temp: temp ?? 0,
      weather: weather?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [dt, temp, weather];
}
