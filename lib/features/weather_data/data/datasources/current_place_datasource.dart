import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../model/current_place_model.dart';
import 'current_location_datasource.dart';

abstract class CurrentPlaceDataSource {
  Future<CurrentPlaceModel> getCurrentPlace();
  String getCurrentDate();
}

class CurrentPlaceDataSourceImpl implements CurrentPlaceDataSource {
  final CurrentLocationDataSource currentLocationDataSource;

  CurrentPlaceDataSourceImpl({required this.currentLocationDataSource});

  @override
  Future<CurrentPlaceModel> getCurrentPlace() async {
    String date = getCurrentDate();
    final position = await currentLocationDataSource.getCurrentPosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latitude, longitude);
    String placeName = placeMark[0].locality ?? '';

    return CurrentPlaceModel(place: placeName, date: date);
  }

  @override
  String getCurrentDate() {
    String date = DateFormat("yMMMMd").format(DateTime.now());
    return date;
  }
}
