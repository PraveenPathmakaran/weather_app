import 'package:equatable/equatable.dart';

class CurrentPlaceEntity extends Equatable {
  final String place;
  final String date;
  final String lat;
  final String lon;
  const CurrentPlaceEntity({
    required this.place,
    required this.date,
    required this.lat,
    required this.lon,
  });
  @override
  List<Object?> get props => [place, date, lat, lon];
}
