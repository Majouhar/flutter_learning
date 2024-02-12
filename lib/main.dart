import 'package:flutter/cupertino.dart';
import 'package:go_moon/pages/ibm_main.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "IBMI",
      routes: {'/': (context) => const MainPage()},
      initialRoute: '/',
    );
  }
}
