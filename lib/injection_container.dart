import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_app/features/weather_data/data/datasources/current_weather_remote_data_source.dart';
import 'package:weather_app/features/weather_data/data/repository/current_weather_repository.dart';
import 'package:weather_app/features/weather_data/domain/repository/current_weather_repository.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';

import 'features/weather_data/data/datasources/current_location_datasource.dart';
import 'features/weather_data/data/datasources/current_place_datasource.dart';
import 'features/weather_data/data/repository/current_place_repository_impl.dart';
import 'features/weather_data/domain/repository/current_place_repository.dart';
import 'features/weather_data/domain/usecases/get_current_place_usecase.dart';
import 'features/weather_data/domain/usecases/get_current_weather_usecase.dart';
import 'features/weather_data/presentation/bloc/current_place_bloc/current_place_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory<CurrentPlaceBloc>(
      () => CurrentPlaceBloc(currentPlaceRepository: sl()));
  //usecases
  sl.registerLazySingleton<GetCurrentPlace>(
      () => GetCurrentPlace(repository: sl()));
  //Repository

  sl.registerLazySingleton<CurrentPlaceRepository>(
      () => CurrentPlaceRepositoryImpl(currentPlaceDataSource: sl()));

  //Data Sources

  sl.registerLazySingleton<CurrentLocationDataSource>(
      () => CurrentLocationDataSourceImpl());
  sl.registerLazySingleton<CurrentPlaceDataSource>(
      () => CurrentPlaceDataSourceImpl(currentLocationDataSource: sl()));
  //core

  //external

  ////////////////////////////////////////////////////////////////////////

  //Bloc
  sl.registerFactory<CurrentWeatherBloc>(() => CurrentWeatherBloc(repo: sl()));
  //usecases
  sl.registerLazySingleton<GetCurrentWeather>(
      () => GetCurrentWeather(repository: sl()));
  //repository

  sl.registerLazySingleton<CurrentWeatherRepository>(
      () => CurrentWeatherRepositoryImpl(repo: sl()));
  //data source

  sl.registerLazySingleton<CurrentWeatherRemoteDataSource>(
      () => CurrentWeatherRemoteDataSourceImpl(client: sl()));
  //core

  //external
  sl.registerLazySingleton<Client>(() => Client());
}
