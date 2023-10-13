import 'package:flutter/material.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/current_weather_more_detail_widget.dart';
import 'package:weather_app/features/weather_data/presentation/widgets/temparature_area_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        //temperature area
        TemperatureAreaWidget(),

        SizeManager.kHeight20,
        //more details - windspeed,humidity,clouds
        CurrentWeatherMoreDetailWidget()
      ],
    );
  }
}
