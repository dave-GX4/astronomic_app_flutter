import 'package:app_rest/core/di/di.dart' as di;
import 'package:app_rest/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await di.init();
  
  runApp(const MainApp());
}