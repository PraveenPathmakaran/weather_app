import 'package:equatable/equatable.dart';

import 'weather.dart';

class DailyEntity extends Equatable {
  final int dt;
  final TempEntity tempEntity;
  final List<WeatherEntity> weather;

  const DailyEntity({
    required this.dt,
    required this.tempEntity,
    required this.weather,
  });
  static DailyEntity emptyDailyEntity() {
    return DailyEntity(
      dt: 0,
      tempEntity: TempEntity.emptyTempModel(),
      weather: const [],
    );
  }

  @override
  List<Object?> get props => [dt, tempEntity, weather];
}

class TempEntity extends Equatable {
  final double day;
  final int min;
  final int max;
  final double night;
  final double eve;
  final double morn;

  const TempEntity({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  static TempEntity emptyTempModel() {
    return const TempEntity(
      day: 0,
      eve: 0,
      max: 0,
      min: 0,
      morn: 0,
      night: 0,
    );
  }

  @override
  List<Object?> get props => [day, min, max, night, eve, morn];
}
