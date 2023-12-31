import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/errors/usecase/usecase.dart';
import '../entity/place/current_place_entity.dart';
import '../repository/current_place_repository.dart';

class GetCurrentPlace implements UseCase<CurrentPlaceEntity, NoParams> {
  final CurrentPlaceRepository repository;

  GetCurrentPlace({required this.repository});
  @override
  Future<Either<Failure, CurrentPlaceEntity>> call(NoParams params) async {
    return await repository.getCurrentPlace();
  }
}
