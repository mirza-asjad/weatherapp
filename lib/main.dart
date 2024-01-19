import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Models/weather_model.dart';
import 'package:weatherapp/Start/api_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Database/local_database.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  
  // Register the adapter
  Hive.registerAdapter(WeatherLocalDatabaseAdapter());
  
  await Hive.openBox('myBox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherModel(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ApiCalling(),
      ),
    );
  }
}
