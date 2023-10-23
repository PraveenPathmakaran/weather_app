import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';

import '../../../../network/network_info.dart';
import '../../domain/repository/current_place_repository.dart';
import '../datasources/current_place_datasource.dart';
import '../model/place/current_place_model.dart';

class CurrentPlaceRepositoryImpl implements CurrentPlaceRepository {
  final CurrentPlaceDataSource currentPlaceDataSource;
  final NetworkInfo networkInfo;

  CurrentPlaceRepositoryImpl({
    required this.currentPlaceDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CurrentPlaceModel>> getCurrentPlace() async {
    try {
      if (await networkInfo.isConnected) {
        final currentPlace = await currentPlaceDataSource.getCurrentPlace();
        return right(currentPlace);
      } else {
        return left(NoInternetConnectionFailure());
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
