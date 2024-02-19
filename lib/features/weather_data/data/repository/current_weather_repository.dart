import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_weather_repository.dart';

import '../../../../network/network_info.dart';
import '../datasources/current_weather_remote_data_source.dart';
import '../model/weather/weather_data.dart';

class CurrentWeatherRepositoryImpl extends CurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource repo;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CurrentWeatherRepositoryImpl({
    required this.repo,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, WeatherDataEntity>> getWeather({
    required String lat,
    required String lon,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final WeatherDataModel weather =
            await repo.getWeather(lat: lat, lon: lon);

        localDataSource.cacheWeather(
            key: cachedWeather, weatherDataModel: weather.toJson());
        return right(weather.toDomain());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final Map<String, dynamic> placeModel =
            await localDataSource.getLastWeather(key: cachedWeather);
        final weather = WeatherDataModel.fromJson(placeModel);

        return right(weather.toDomain());
      } catch (e) {
        return left(CacheFailure());
      }
    }
  }
}
