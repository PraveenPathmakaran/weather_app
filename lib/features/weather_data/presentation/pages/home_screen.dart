import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';

import '../../../../injection_container.dart';
import '../bloc/current_place_bloc/current_place_bloc.dart';
import '../bloc/current_weather_bloc/current_weather_bloc.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentPlaceBloc>(
            create: (context) =>
                sl<CurrentPlaceBloc>()..add(FetchCurrentPlaceEvent())),
        BlocProvider<CurrentWeatherBloc>(
          create: (context) => sl<CurrentWeatherBloc>(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
            child: ListView(
          children: const <Widget>[
            SizeManager.kHeight20,
            HeaderWidget(),
            CurrentWeatherWidget(),
          ],
        )),
      ),
    );
  }
}
