import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';
import 'package:weather_app/core/utils/show_toast.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';
import '../bloc/current_place_bloc/current_place_bloc.dart';
import 'header_loaded_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentPlaceBloc, CurrentPlaceState>(
      listener: (context, state) {
        if (state is CurrentPlaceErrorState) {
          if (state.failure is LocationPermissionDeniedFailure) {
            return toast(msg: "Please Turn on Location");
          }
        }
        if (state is CurrentPlaceLoadedState) {
          WeatherParams params = WeatherParams(
              lat: state.currentPlaceModel.lat,
              lon: state.currentPlaceModel.lon);
          context
              .read<CurrentWeatherBloc>()
              .add(FetchCurrentWeather(params: params));
        }
      },
      builder: (context, state) {
        if (state is CurrentPlaceLoadingState) {
          return const LoadingWidget();
        } else if (state is CurrentPlaceLoadedState) {
          return HeaderLoadedWidget(placeModel: state.currentPlaceModel);
        } else if (state is CurrentPlaceErrorState) {
          return const Center(child: Text("Something went wrong"));
        } else {
          return SizeManager.kSize;
        }
      },
    );
  }
}
