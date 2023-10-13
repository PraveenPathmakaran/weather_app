import 'package:flutter/material.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/utils/utils.dart';

import '../../domain/entity/weather/weather_data_hourly.dart';

class HourlyDataWidget extends StatelessWidget {
  const HourlyDataWidget({
    super.key,
    required this.hourly,
  });

  final List<HourlyEntity> hourly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourly.length,
            itemBuilder: (context, index) => GestureDetector(
                child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0.5, 0),
                      blurRadius: 30,
                      spreadRadius: 1,
                      color: ColorManger.dividerLine.withAlpha(150))
                ],
                gradient: const LinearGradient(
                  colors: [
                    ColorManger.firstGradientColor,
                    ColorManger.secondGradientColor,
                  ],
                ),
              ),
              child: HourlyDetails(
                timeStamp: hourly[index].dt,
                temp: hourly[index].temp,
                weatherIcon: hourly[index].weather[0].icon,
              ),
            )),
          ),
        ),
      ],
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  const HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(AppUtils.getTime(timeStamp)),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp"),
        )
      ],
    );
  }
}
