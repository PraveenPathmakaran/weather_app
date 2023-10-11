import 'package:flutter/material.dart';
import 'package:weather_app/injection_container.dart';
import 'features/weather_data/presentation/pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
