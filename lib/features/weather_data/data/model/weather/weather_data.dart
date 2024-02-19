import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_current.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_daily.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data_hourly.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_current.dart';

import '../../../domain/entity/weather/weather_data.dart';

class WeatherDataModel extends Equatable {
  final List<HourlyModel>? hourly;
  final List<DailyModel>? daily;
  final CurrentModel? current;

  const WeatherDataModel({
    required this.hourly,
    required this.daily,
    required this.current,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      hourly: (json["hourly"] as List)
          .map((e) => HourlyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      daily: (json["daily"] as List)
          .map((e) => DailyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      current: CurrentModel.fromJson(json["current"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hourly": hourly?.map((e) => e.toJson()).toList(),
      "daily": daily?.map((e) => e.toJson()).toList(),
      "current": current?.toJson()
    };
  }

  WeatherDataEntity toDomain() {
    return WeatherDataEntity(
      current: current?.toDomain() ?? CurrentEntity.emptyCurrentEntity(),
      daily: daily!
          .map((e) => e.toDomain())
          .toList(), //todo need to change null safety operator
      hourly: hourly!.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  List<Object?> get props => [hourly, daily, current];
}
