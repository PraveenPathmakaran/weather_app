import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather.dart';

class WeatherModel extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherModel({this.id, this.main, this.description, this.icon});

  // from json
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };

  WeatherEntity toDomain() {
    return WeatherEntity(
      id: id ?? 0,
      main: main ?? "",
      description: description ?? "",
      icon: icon ?? "",
    );
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}
