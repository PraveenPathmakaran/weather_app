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
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: dailyDataForeCast.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(
                                AppUtils.getDay(dailyDataForeCast[index].dt),
                                style: const TextStyle(
                                  color: ColorManger.textColorBlack,
                                  fontSize: 13,
                                ),
                              )),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset(
                                "assets/weather/${dailyDataForeCast[index].weather[0].icon}.png"),
                          ),
                          Text(
                              "${dailyDataForeCast[index].tempEntity.max}/${dailyDataForeCast[index].tempEntity.min}"), //todo add degree symbol
                          Container(
                            height: 1,
                            color: ColorManger.dividerLine,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
