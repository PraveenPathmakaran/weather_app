import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entity/current_place_entity.dart';

abstract class CurrentPlaceRepository {
  Future<Either<Failure, CurrentPlaceEntity>> getCurrentPlace();
}
