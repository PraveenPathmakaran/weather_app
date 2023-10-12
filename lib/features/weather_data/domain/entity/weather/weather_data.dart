import 'package:equatable/equatable.dart';

import 'weather_data_current.dart';
import 'weather_data_daily.dart';
import 'weather_data_hourly.dart';

class WeatherDataEntity extends Equatable {
  final HourlyEntity hourly;
  final DailyEntity daily;
  final CurrentEntity current;

  const WeatherDataEntity({
    required this.hourly,
    required this.daily,
    required this.current,
  });

  @override
  List<Object?> get props => [hourly, daily, current];
}
