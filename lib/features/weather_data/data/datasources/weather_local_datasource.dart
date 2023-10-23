import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class WeatherLocalDataSource {
  Future<Map<String, dynamic>> getLastWeather({required String key});
  Future<void> cacheWeather(
      {required String key, required Map<String, dynamic> weatherDataModel});
}

const cachedWeather = 'CACHED_WEATHER';
const cachedPlace = 'CACHED_PLACE';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(
      {required String key, required Map<String, dynamic> weatherDataModel}) {
    return sharedPreferences.setString(
      key,
      json.encode(weatherDataModel),
    );
  }

  @override
  Future<Map<String, dynamic>> getLastWeather({required String key}) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return Future.value(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
