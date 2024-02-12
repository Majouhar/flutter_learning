import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/models/app_config.dart';
import 'package:go_moon/pages/game_page.dart';
import 'package:go_moon/pages/trivia_home.dart';
import 'package:go_moon/services/http_service.dart';

void main() async {
  // await Hive.initFlutter("hive_boxes");
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString("assets/config/main.json");

  Map _configData = jsonDecode(_configContent);
  GetIt.instance.registerSingleton<AppConfig>(
      AppConfig(COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],TRIVIA_API_BASE_URL: _configData["TRIVIA_API_BASE_URL"]));
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(HTTPService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trivia",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ArchitectsDoctor',
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      ),
      home: TriviaHomePage(),
    );
  }
}
