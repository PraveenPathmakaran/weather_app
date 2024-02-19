import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/features/weather_data/presentation/bloc/theme_bloc/theme_bloc.dart';

import '../../domain/entity/weather/weather_data_current.dart';

class TemperatureAreaWidget extends StatelessWidget {
  const TemperatureAreaWidget({
    super.key,
    required this.current,
  });
  final CurrentEntity current;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ThemeBloc>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image.asset(
          "assets/weather/${current.weather[0].icon}.png",
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
              text: "${current.temp.toInt()}°",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68,
                color: bloc.state.isDark ? Colors.white : Colors.black,
              )),
          TextSpan(
              text: current.weather[0].description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              )),
        ]))
      ],
    );
  }
}
