import 'dart:convert';

import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather_data/data/model/weather/weather_data.dart';
import 'package:http/http.dart';

import '../../../../core/api/api_key.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<WeatherDataModel> getWeather({
    required String lat,
    required String lon,
  });
}

class CurrentWeatherRemoteDataSourceImpl
    implements CurrentWeatherRemoteDataSource {
  final Client client;

  CurrentWeatherRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<WeatherDataModel> getWeather(
      {required String lat, required String lon}) async {
    try {
      final Response response = await client.get(Uri.parse(apiUrl(lat, lon)));
      final Map<String, dynamic> jsonString = jsonDecode(response.body);

      final weahterData = WeatherDataModel.fromJson(jsonString);
      return weahterData;
    } catch (e) {
      throw ServerException();
    }
  }
}

String apiUrl(lat, lon) {
  String url;
  url =
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=&appid=$apiKey&units=metric&exclude=minutely';
  return url;
}
