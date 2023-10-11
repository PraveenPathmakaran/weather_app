part of 'current_place_bloc.dart';

sealed class CurrentPlaceEvent extends Equatable {
  const CurrentPlaceEvent();

  @override
  List<Object> get props => [];
}
class FetchCurrentPlaceEvent extends CurrentPlaceEvent{}