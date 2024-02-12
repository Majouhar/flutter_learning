import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/pages/fin_home.dart';
import 'package:go_moon/pages/fin_login.dart';
import 'package:go_moon/pages/fin_reg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_moon/services/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Finstagram",
        theme: ThemeData(primarySwatch: Colors.red),
        initialRoute: 'login',
        routes: {
          'register': (context) => FinReg(),
          'login': (context) => FinLogin(),
          'home': (context) => FinHome(),
        });
  }
}
