import 'package:equatable/equatable.dart';
import 'weather.dart';

class HourlyEntity extends Equatable {
  final int dt;
  final int temp;

  final List<WeatherEntity> weather;

  const HourlyEntity({
    required this.dt,
    required this.temp,
    required this.weather,
  });

static  HourlyEntity emptyHourlyEntity() {
    return const HourlyEntity(
      dt: 0,
      temp: 0,
      weather: [],
    );
  }

  @override
  List<Object?> get props => [dt, temp, weather];
}
