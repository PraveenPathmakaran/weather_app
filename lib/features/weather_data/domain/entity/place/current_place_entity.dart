import 'package:equatable/equatable.dart';

class CurrentPlaceEntity extends Equatable {
  final String place;
  final String date;
  const CurrentPlaceEntity({
    required this.place,
    required this.date,
  });
  @override
  List<Object?> get props => [place, date];
}
