import 'package:flutter/material.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/utils/utils.dart';

import '../../domain/entity/weather/weather_data_hourly.dart';

class HourlyDataWidget extends StatefulWidget {
  const HourlyDataWidget({
    super.key,
    required this.hourly,
  });

  final List<HourlyEntity> hourly;

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  int cardIndex = 0;
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
            itemCount: widget.hourly.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  cardIndex = index;
                  setState(() {});
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManger.dividerLine.withAlpha(10),
                      )
                    ],
                    gradient: cardIndex == index
                        ? const LinearGradient(
                            colors: [
                              ColorManger.firstGradientColor,
                              ColorManger.secondGradientColor,
                            ],
                          )
                        : null,
                  ),
                  child: HourlyDetails(
                    timeStamp: widget.hourly[index].dt,
                    temp: widget.hourly[index].temp,
                    weatherIcon: widget.hourly[index].weather[0].icon,
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
