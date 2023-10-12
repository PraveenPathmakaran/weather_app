import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_weather_repository.dart';
import 'package:weather_app/features/weather_data/domain/usecases/get_current_weather_usecase.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final CurrentWeatherRepository repo;
  CurrentWeatherBloc({required this.repo}) : super(CurrentWeatherInitial()) {
    on<FetchCurrentWeather>((event, emit) async {
      emit(CurrentWeatherLoading());

      final weather =
          await repo.getWeather(lat: event.params.lat, lon: event.params.lon);

      await weather.fold(
          (failure) async => emit(CurrentWeatherError(failure: failure)),
          (weather) async => emit(CurrentWeatherLoaded(weather: weather)));
    });
  }
}
