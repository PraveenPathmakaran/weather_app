import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';
import 'package:weather_app/core/widgets/loading_widget.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/show_toast.dart';
import '../bloc/current_weather_bloc/current_weather_bloc.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/header_loaded_widget.dart';
import '../widgets/theme_switch_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final stateData = context.read<CurrentWeatherBloc>().state;
    switch (state) {
      case AppLifecycleState.resumed:
        if (stateData is! CurrentWeatherError) {
          context.read<CurrentWeatherBloc>().add(FetchCurrentWeather());
        }

      default:
        // Do something when the app is not visible...
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
        listener: (context, state) {
          if (state is CurrentWeatherError) {
            if (state.failure is LocationPermissionDeniedFailure) {
              return toast(msg: "Please Turn on Location");
            }
          }
        },
        builder: (context, state) {
          if (state is CurrentWeatherLoading) {
            return const LoadingWidget();
          }
          if (state is CurrentWeatherError) {
            log(state.failure.toString());
            if (state.failure is LocationPermissionDeniedFailure) {
              return Center(
                child: GestureDetector(
                  onTap: () async {
                    await Geolocator.openLocationSettings();
                  },
                  child: const Text("Click to turn on location"),
                ),
              );
            }

            if (state.failure is LocationPermissionDeniedForEverFailure) {
              return GestureDetector(
                  onTap: () async {
                    await Geolocator.openLocationSettings();
                  },
                  child: const Text("Click to turn on location"));
            }
            if (state.failure is ServerFailure) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (state.failure is NoInternetConnectionFailure) {
              return const Center(
                child: Text("No internet connection"),
              );
            }
          }
          if (state is CurrentWeatherLoaded) {
            return ListView(
              children: <Widget>[
                SizeManager.kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderLoadedWidget(placeModel: state.currentPlaceModel),
                    const ThemeSwitchWidget(),
                  ],
                ),
                const CurrentWeatherWidget(),
              ],
            );
          }
          return const SizedBox();
        },
      )),
    );
  }
}
