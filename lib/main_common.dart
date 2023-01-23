import 'package:clean_arquitecture_project/config_reader.dart';
import 'package:clean_arquitecture_project/environment.dart';
import 'package:clean_arquitecture_project/src/core/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

Future<void> mainCommon(String env) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  // Load the JSON config into memory
  await ConfigReader.initialize();

  late Color primaryColor;
  switch (env) {
    case Environment.dev:
      primaryColor = Colors.blue;
      break;
    case Environment.prod:
      primaryColor = Colors.red;
      break;
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(
    Provider.value(
      value: primaryColor,
      child: const App(),
    ),
  );
}
