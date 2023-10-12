import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_current.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_daily.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_hourly.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_current.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_daily.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_hourly.dart';

import '../../../domain/entity/weather/weather_data.dart';

class WeatherDataModel extends Equatable {
  final HourlyModel? hourly;
  final DailyModel? daily;
  final CurrentModel? current;

  const WeatherDataModel({
    required this.hourly,
    required this.daily,
    required this.current,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      hourly: HourlyModel.fromJson(json["hourly"] as Map<String, dynamic>),
      daily: DailyModel.fromJson(json["hourly"] as Map<String, dynamic>),
      current: CurrentModel.fromJson(json["hourly"] as Map<String, dynamic>),
    );
  }

  WeatherDataEntity toDomain() {
    return WeatherDataEntity(
      current: current?.toDomain() ?? CurrentEntity.emptyCurrentEntity(),
      daily: daily?.toDomain() ?? DailyEntity.emptyDailyEntity(),
      hourly: hourly?.toDomain() ?? HourlyEntity.emptyHourlyEntity(),
    );
  }

  @override
  List<Object?> get props => [hourly, daily, current];
}
