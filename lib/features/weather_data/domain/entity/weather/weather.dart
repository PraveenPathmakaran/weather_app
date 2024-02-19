import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

 static WeatherEntity emptyWeatherEntity() {
    return const WeatherEntity(
      id: 0,
      main: "",
      description: "",
      icon: "",
    );
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}
