import 'package:flutter/material.dart';
import '../../data/model/current_place_model.dart';

class HeaderLoadedWidget extends StatelessWidget {
  final CurrentPlaceModel placeModel;
  const HeaderLoadedWidget({
    super.key,
    required this.placeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            placeModel.place,
            style: const TextStyle(fontSize: 35, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            placeModel.date,
            style:
                TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
          ),
        ),
      ],
    );
  }
}
