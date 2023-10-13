import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';
import 'package:weather_app/core/widgets/loading_widget.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';

class TemperatureAreaWidget extends StatelessWidget {
  const TemperatureAreaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        if (state is CurrentWeatherLoading) {
          return const LoadingWidget();
        }
        if (state is CurrentWeatherLoaded) {
          log(state.weather.current.weather[0].toString());
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                "assets/weather/${state.weather.current.weather[0].icon}.png",
                height: 80,
                width: 80,
              ),
              Container(
                height: 50,
                width: 1,
                color: ColorManger.dividerLine,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${state.weather.current.temp.toInt()}°",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 68,
                      color: ColorManger.textColorBlack,
                    )),
                TextSpan(
                    text: state.weather.current.weather[0].description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    )),
              ]))
            ],
          );
        }
        return SizeManager.kSize;
      },
    );
  }
}
