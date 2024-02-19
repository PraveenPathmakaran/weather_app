import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_daily.dart';

import 'weather.dart';

class DailyModel extends Equatable {
  final int? dt;
  final TempModel? tempModel;

  final List<WeatherModel>? weather;

  const DailyModel({
    this.dt,
    this.tempModel,
    this.weather,
  });

  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
        dt: json['dt'] as int?,
        tempModel: json['temp'] == null
            ? null
            : TempModel.fromJson(json['temp'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': tempModel?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
      };

  DailyEntity toDomain() {
    return DailyEntity(
      dt: dt ?? 0,
      tempEntity: tempModel?.toDomain() ?? TempEntity.emptyTempModel(),
      weather: weather?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [dt, tempModel, weather];
}

class TempModel extends Equatable {
  final double? day;
  final int? min;
  final int? max;
  final double? night;
  final double? eve;
  final double? morn;

  const TempModel({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  factory TempModel.fromJson(Map<String, dynamic> json) => TempModel(
        day: (json['day'] as num?)?.toDouble(),
        min: (json['min'] as num?)?.round(),
        max: (json['max'] as num?)?.round(),
        night: (json['night'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
      };

  TempEntity toDomain() {
    return TempEntity(
      day: day ?? 0,
      min: min ?? 0,
      max: max ?? 0,
      night: night ?? 0,
      eve: eve ?? 0,
      morn: morn ?? 0,
    );
  }

  @override
  List<Object?> get props => [day, min, max, night, eve, morn];
}
