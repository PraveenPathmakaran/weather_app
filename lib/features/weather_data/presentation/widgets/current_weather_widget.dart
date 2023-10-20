import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/comfort_level.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/current_weather_more_detail_widget.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/daily_data_forecast_widget.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/temparature_area_widget.dart';

import '../bloc/current_weather_bloc/current_weather_bloc.dart';
import 'hourly_data_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        if (state is CurrentWeatherLoaded) {
          return Column(
            children: <Widget>[
              //temperature area
              TemperatureAreaWidget(current: state.weather.current),

              SizeManager.kHeight20,
              //more details - windspeed,humidity,clouds
              CurrentWeatherMoreDetailWidget(current: state.weather.current),
              HourlyDataWidget(hourly: state.weather.hourly),
              DailyDataForeCast(
                dailyDataForeCast: state.weather.daily,
              ),
              Container(
                height: 1,
                color: ColorManger.dividerLine,
              ),
              SizeManager.kHeight10,
              ComfortLevelWidget(
                weather: state.weather.current,
              )
            ],
          );
        } else {
          return SizeManager.kHeight10;
        }
      },
    );
  }
}
