import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';

double calculateBMI(int _weight, int _height) {
  return (_weight) * 10000 / pow(_height, 2);
}

Future<String> calculateBMIAsync(Dio dio) async {
  var result = await dio.get("https://www.jsonkeeper.com/b/AKFA");
  var data = jsonDecode(result.data) as Map;
  var bmi = calculateBMI(data["Sergio Ramos"][0], data["Sergio Ramos"][1]);
  return bmi.toStringAsFixed(2);
}
