import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/image_manager/image_manager.dart';
import 'package:weather_app/core/size_manager/size_manager.dart';

import '../bloc/current_weather_bloc/current_weather_bloc.dart';

class CurrentWeatherMoreDetailWidget extends StatelessWidget {
  const CurrentWeatherMoreDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        if (state is CurrentWeatherLoaded) {
          return Column(
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MoreDetailImageWidget(
                    imagePath: ImageManager.windspeed,
                  ),
                  MoreDetailImageWidget(
                    imagePath: ImageManager.clouds,
                  ),
                  MoreDetailImageWidget(
                    imagePath: ImageManager.humidity,
                  ),
                ],
              ),
              SizeManager.kHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MoreDetailTextWidget(
                    text: "${state.weather.current.windSpeed}km/h",
                  ),
                  MoreDetailTextWidget(
                    text: "${state.weather.current.clouds}%",
                  ),
                  MoreDetailTextWidget(
                    text: "${state.weather.current.humidity}%",
                  ),
                ],
              )
            ],
          );
        }
        return SizeManager.kSize;
      },
    );
  }
}

class MoreDetailTextWidget extends StatelessWidget {
  const MoreDetailTextWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 60,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MoreDetailImageWidget extends StatelessWidget {
  const MoreDetailImageWidget({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorManger.cardColor,
          borderRadius: BorderRadius.circular(15)),
      child: Image.asset(imagePath),
    );
  }
}
