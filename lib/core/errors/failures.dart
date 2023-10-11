import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
  @override
  List<Object?> get props => [];
}

class LocationPermissionDeniedFailure extends Failure {}
class UnknownFailure extends Failure {}

class LocationPermissionDeniedForEverFailure extends Failure {}