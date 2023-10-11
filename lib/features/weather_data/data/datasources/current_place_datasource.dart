import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather_data/data/model/current_place_model.dart';


abstract class CurrentPlaceDataSource {
  Future<Position> getCurrentPosition();
  Future<CurrentPlaceModel> getCurrentPlace();
  String getCurrentDate();
}

class CurrentPlaceDataSourceImpl implements CurrentPlaceDataSource {

  @override
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationPermissionDeniedException();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForEverException();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Future<CurrentPlaceModel> getCurrentPlace() async {
    String date = getCurrentDate();
    final position = await getCurrentPosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latitude, longitude);
    String placeName = placeMark[0].locality ?? '';

    return CurrentPlaceModel(place: placeName, date: date);
  }

  @override
  String getCurrentDate() {
    String date = DateFormat("yMMMMD").format(DateTime.now());
    return date;
  }
}
