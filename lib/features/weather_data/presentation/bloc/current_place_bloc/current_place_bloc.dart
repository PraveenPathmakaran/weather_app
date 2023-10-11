import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_data/data/model/current_place_model.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_place_repository.dart';

import '../../../../../core/errors/failures.dart';

part 'current_place_event.dart';
part 'current_place_state.dart';

class CurrentPlaceBloc extends Bloc<CurrentPlaceEvent, CurrentPlaceState> {
  final CurrentPlaceRepository currentPlaceRepository;
  CurrentPlaceBloc({required this.currentPlaceRepository})
      : super(CurrentPlaceInitial()) {
    on<FetchCurrentPlaceEvent>((event, emit) async {
      emit(CurrentPlaceLoadingState());
      final currentPlace = await currentPlaceRepository.getCurrentPlace();

      await currentPlace.fold(
          (failure) async => CurrentPlaceErrorState(failure: failure),
          (currentPlace) async => emit(CurrentPlaceLoadedState(
                currentPlaceModel: currentPlace as CurrentPlaceModel,
              )));
    });
  }
}
