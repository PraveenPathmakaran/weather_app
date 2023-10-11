part of 'current_place_bloc.dart';

sealed class CurrentPlaceState extends Equatable {
  const CurrentPlaceState();

  @override
  List<Object> get props => [];
}

final class CurrentPlaceInitial extends CurrentPlaceState {}

final class CurrentPlaceLoadingState extends CurrentPlaceState {}
final class PermissionSuccessState extends CurrentPlaceState {}

final class CurrentPlaceErrorState extends CurrentPlaceState {
  final Failure failure;

  const CurrentPlaceErrorState({required this.failure});
}

final class CurrentPlaceLoadedState extends CurrentPlaceState {
  final CurrentPlaceModel currentPlaceModel;
  const CurrentPlaceLoadedState({required this.currentPlaceModel});
}
