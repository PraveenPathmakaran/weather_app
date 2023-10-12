import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entity/weather/weather_data.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Failure, WeatherDataEntity>> getWeather({
    required String lat,
    required String lon,
  });
}
