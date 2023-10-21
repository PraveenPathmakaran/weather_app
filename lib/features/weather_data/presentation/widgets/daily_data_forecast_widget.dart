import 'package:flutter/material.dart';
import 'package:weather_app/core/color_manager/color_manager.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/weather_data/domain/entity/weather/weather_data_daily.dart';

class DailyDataForeCast extends StatelessWidget {
  final List<DailyEntity> dailyDataForeCast;
  const DailyDataForeCast({
    super.key,
    required this.dailyDataForeCast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: ColorManger.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Next Days",
              style: TextStyle(
                color: ColorManger.textColorBlack,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              itemCount: dailyDataForeCast.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppUtils.getDay(dailyDataForeCast[index].dt),
                        style: const TextStyle(
                          color: ColorManger.textColorBlack,
                          fontSize: 13,
                        ),
                      ),
                      Image.asset(
                        "assets/weather/${dailyDataForeCast[index].weather[0].icon}.png",
                        height: 30,
                      ),
                      Text(
                          "${dailyDataForeCast[index].tempEntity.max}/${dailyDataForeCast[index].tempEntity.min}"),
                      //todo add degree symbol
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
