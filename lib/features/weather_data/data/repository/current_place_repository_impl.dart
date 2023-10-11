import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/data/model/current_place_model.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_place_repository.dart';

import '../datasources/current_place_datasource.dart';

class CurrentPlaceRepositoryImpl implements CurrentPlaceRepository {
  final CurrentPlaceDataSource currentPlaceDataSource;

  CurrentPlaceRepositoryImpl({required this.currentPlaceDataSource});
  @override
  Future<Either<Failure, CurrentPlaceModel>> getCurrentPlace() async {
    try {
      final currentPlace = await currentPlaceDataSource.getCurrentPlace();
      return right(currentPlace);
    } on LocationPermissionDeniedFailure {
      return left(LocationPermissionDeniedFailure());
    } on LocationPermissionDeniedForEverFailure {
      return left(LocationPermissionDeniedForEverFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
