import 'package:flutter/material.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/show_toast.dart';
import 'package:weather_app/features/weather_data/data/datasources/current_place_datasource.dart';
import 'package:weather_app/features/weather_data/data/repository/current_place_repository_impl.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/current_place_bloc/current_place_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentPlaceBloc>(
      create: (context) => CurrentPlaceBloc(
          currentPlaceRepository: CurrentPlaceRepositoryImpl(
        currentPlaceDataSource: CurrentPlaceDataSourceImpl(),
      ))
        ..add(FetchCurrentPlaceEvent()),
      child: BlocConsumer<CurrentPlaceBloc, CurrentPlaceState>(
        listener: (context, state) {
          if (state is CurrentPlaceErrorState) {
            if (state.failure is LocationPermissionDeniedFailure) {
              return toast(msg: "Please Turn on Location");
            }
            if (state is PermissionSuccessState) {
              context.read<CurrentPlaceBloc>().add(FetchCurrentPlaceEvent());
            }
          }
        },
        builder: (context, state) {
          if (state is CurrentPlaceLoadingState) {
            return const LoadingWidget();
          } else if (state is CurrentPlaceLoadedState) {
            return Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    state.currentPlaceModel.place,
                    style: const TextStyle(fontSize: 35, height: 2),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    state.currentPlaceModel.date,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey[700], height: 1.5),
                  ),
                ),
              ],
            );
          } else if (state is CurrentPlaceErrorState) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
