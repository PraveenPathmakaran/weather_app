part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrentWeather extends CurrentWeatherEvent {
  final WeatherParams params;

  const FetchCurrentWeather({
    required this.params,
  });
}
