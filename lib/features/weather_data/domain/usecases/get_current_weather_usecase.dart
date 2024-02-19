import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/errors/usecase/usecase.dart';
import '../entity/weather/weather_data.dart';
import '../repository/current_weather_repository.dart';

class GetCurrentWeather implements UseCase<WeatherDataEntity, WeatherParams> {
  final CurrentWeatherRepository repository;

  GetCurrentWeather({required this.repository});
  @override
  Future<Either<Failure, WeatherDataEntity>> call(WeatherParams params) async {
    return await repository.getWeather(lat: params.lat, lon: params.lon);
  }
}

class WeatherParams extends Equatable {
  final String lat;
  final String lon;

  const WeatherParams({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [lat, lon];
}
