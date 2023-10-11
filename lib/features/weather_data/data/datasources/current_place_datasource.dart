import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather_data/data/model/current_place_model.dart';

abstract class CurrentPlaceDataSource {
  Future<Position> getCurrentPosition();
  Future<CurrentPlaceModel> getCurrentPlace();
}

class CurrentPlaceDataSourceImpl implements CurrentPlaceDataSource {
  @override
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw GpsServiceNotEnabledException();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw LocationPermissionDeniedForEverException();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Future<CurrentPlaceModel> getCurrentPlace() async {
    String date = DateFormat("yMMMMD").format(DateTime.now());
    final position = await getCurrentPosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latitude, longitude);
    String placeName = placeMark[0].locality ?? '';

    return CurrentPlaceModel(place: placeName, date: date);
  }
}
