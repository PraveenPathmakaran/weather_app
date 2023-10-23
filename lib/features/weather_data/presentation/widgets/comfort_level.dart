import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/theme_bloc/theme_bloc.dart';

import '../../domain/entity/weather/weather_data_current.dart';

class ComfortLevelWidget extends StatelessWidget {
  const ComfortLevelWidget({
    super.key,
    required this.weather,
  });

  final CurrentEntity weather;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ThemeBloc>(context, listen: true);
    return Column(
      children: <Widget>[
        Container(
          margin:
              const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: <Widget>[
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weather.humidity.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                        handlerSize: 0, trackWidth: 12, progressBarWidth: 12),
                    infoProperties: InfoProperties(
                        bottomLabelText: "Humidity",
                        mainLabelStyle: TextStyle(
                          color: bloc.state.isDark
                              ? ColorManger.dividerLine
                              : ColorManger.textColorBlack,
                          fontSize: 25,
                        ),
                        bottomLabelStyle: const TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 14,
                          height: 1.5,
                        )),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                      progressBarColors: [
                        ColorManger.firstGradientColor,
                        ColorManger.secondGradientColor
                      ],
                      trackColor: ColorManger.firstGradientColor.withAlpha(100),
                      hideShadow: true,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Feels Like",
                        style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: bloc.state.isDark
                                ? ColorManger.dividerLine
                                : ColorManger.textColorBlack,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "${weather.feelsLike}",
                        style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: bloc.state.isDark
                                ? ColorManger.dividerLine
                                : ColorManger.textColorBlack,
                            fontWeight: FontWeight.w400)),
                  ])),
                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    width: 1,
                    color: ColorManger.dividerLine,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "UV Index",
                        style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: bloc.state.isDark
                                ? ColorManger.dividerLine
                                : ColorManger.textColorBlack,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "${weather.uvIndex}",
                        style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: bloc.state.isDark
                                ? ColorManger.dividerLine
                                : ColorManger.textColorBlack,
                            fontWeight: FontWeight.w400)),
                  ])),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
//todo last row