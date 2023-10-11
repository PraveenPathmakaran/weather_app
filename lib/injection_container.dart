import 'package:get_it/get_it.dart';

import 'features/weather_data/data/datasources/current_location_datasource.dart';
import 'features/weather_data/data/datasources/current_place_datasource.dart';
import 'features/weather_data/data/repository/current_place_repository_impl.dart';
import 'features/weather_data/domain/repository/current_place_repository.dart';
import 'features/weather_data/domain/usecases/get_current_place_usecase.dart';
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
}
