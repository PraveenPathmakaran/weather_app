import '../../../domain/entity/place/current_place_entity.dart';

class CurrentPlaceModel extends CurrentPlaceEntity {
  const CurrentPlaceModel({
    required super.place,
    required super.date,
    required super.lat,
    required super.lon,
  });

  factory CurrentPlaceModel.fromJson(Map<String, dynamic> json) {
    return CurrentPlaceModel(
        place: json["place"],
        date: json["date"],
        lat: json["lat"],
        lon: json["lon"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "place": place,
      "date": date,
      "lat": lat,
      "lon": lon,
    };
  }
}
