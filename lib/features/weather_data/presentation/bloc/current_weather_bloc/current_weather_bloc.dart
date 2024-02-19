import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_weather_repository.dart';

import '../../../data/model/place/current_place_model.dart';
import '../../../domain/repository/current_place_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final CurrentWeatherRepository repo;
  final CurrentPlaceRepository currentPlaceRepository;
  CurrentWeatherBloc({
    required this.repo,
    required this.currentPlaceRepository,
  }) : super(CurrentWeatherInitial()) {
    on<FetchCurrentWeather>((event, emit) async {
      emit(CurrentWeatherLoading());
      final currentPlace = await currentPlaceRepository.getCurrentPlace();
      await currentPlace
          .fold((failure) async => emit(CurrentWeatherError(failure: failure)),
              (currentPlaceDatas) async {
        final weather = await repo.getWeather(
            lat: currentPlaceDatas.lat, lon: currentPlaceDatas.lon);
        await weather.fold(
            (failure) async => emit(CurrentWeatherError(failure: failure)),
            (weather) async => emit(CurrentWeatherLoaded(
                weather: weather,
                currentPlaceModel: currentPlaceDatas as CurrentPlaceModel)));
      });
    });
  }
}
