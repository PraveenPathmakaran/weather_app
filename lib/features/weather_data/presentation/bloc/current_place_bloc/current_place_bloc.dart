import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../data/model/place/current_place_model.dart';
import '../../../domain/repository/current_place_repository.dart';
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
          (failure) async => emit(CurrentPlaceErrorState(failure: failure)),
          (currentPlace) async => emit(CurrentPlaceLoadedState(
                currentPlaceModel: currentPlace as CurrentPlaceModel,
              )));
    });
  }
}
