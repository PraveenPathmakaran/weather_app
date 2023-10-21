import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_weather_repository.dart';

import '../datasources/current_weather_remote_data_source.dart';
import '../model/weather/weather_data.dart';

class CurrentWeatherRepositoryImpl extends CurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource repo;

  CurrentWeatherRepositoryImpl({
    required this.repo,
  });
  @override
  Future<Either<Failure, WeatherDataEntity>> getWeather({
    required String lat,
    required String lon,
  }) async {
    try {
      final WeatherDataModel weather =
          await repo.getWeather(lat: lat, lon: lon);

      return right(weather.toDomain());
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
