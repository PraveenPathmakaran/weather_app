import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/data/datasources/weather_local_datasource.dart';

import '../../../../network/network_info.dart';
import '../../domain/repository/current_place_repository.dart';
import '../datasources/current_place_datasource.dart';
import '../model/place/current_place_model.dart';

class CurrentPlaceRepositoryImpl implements CurrentPlaceRepository {
  final CurrentPlaceDataSource currentPlaceDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;

  CurrentPlaceRepositoryImpl({
    required this.currentPlaceDataSource,
    required this.networkInfo,
    required this.weatherLocalDataSource,
  });
  @override
  Future<Either<Failure, CurrentPlaceModel>> getCurrentPlace() async {
    try {
      if (await networkInfo.isConnected) {
        final CurrentPlaceModel currentPlace =
            await currentPlaceDataSource.getCurrentPlace();
        weatherLocalDataSource.cacheWeather(
            key: cachedPlace, weatherDataModel: currentPlace.toJson());
        return right(currentPlace);
      } else {
        try {
          final Map<String, dynamic> placeModel =
              await weatherLocalDataSource.getLastWeather(key: cachedPlace);
          final currentPlaceModel = CurrentPlaceModel.fromJson(placeModel);

          return right(currentPlaceModel);
        } catch (e) {
          return left(CacheFailure());
        }
      }
    } on LocationPermissionDeniedException {
      return left(LocationPermissionDeniedFailure());
    } on LocationPermissionDeniedForEverException {
      return left(LocationPermissionDeniedForEverFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
