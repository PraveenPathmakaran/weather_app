import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import '../../domain/repository/current_place_repository.dart';
import '../datasources/current_place_datasource.dart';
import '../model/current_place_model.dart';

class CurrentPlaceRepositoryImpl implements CurrentPlaceRepository {
  final CurrentPlaceDataSource currentPlaceDataSource;

  CurrentPlaceRepositoryImpl({required this.currentPlaceDataSource});
  @override
  Future<Either<Failure, CurrentPlaceModel>> getCurrentPlace() async {
    try {
      final currentPlace = await currentPlaceDataSource.getCurrentPlace();
      return right(currentPlace);
    } on LocationPermissionDeniedException {
      return left(LocationPermissionDeniedFailure());
    } on LocationPermissionDeniedForEverException {
      return left(LocationPermissionDeniedForEverFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
