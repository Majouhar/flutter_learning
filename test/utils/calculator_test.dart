import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_moon/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
      "Give Height and Weight When calculate BMI function invoked correct BMI Returnde",
      () {
    const int height = 70, weight = 160;

    double bmi = calculateBMI(weight, height);
    expect(bmi, 326.53061224489795);
  });

  test('Given uri when CalculateBMIAsync invoked the correct', () async {
    final dioMock = DioMock();
    when(() => dioMock.get("https://www.jsonkeeper.com/b/AKFA")).thenAnswer(
      (invocation) => Future.value(
        Response(
            requestOptions:
                RequestOptions(path: "https://www.jsonkeeper.com/b/AKFA"),
            data: '{ "Sergio Ramos": [72, 165]}'),
      ),
    );
    var result = await calculateBMIAsync(dioMock);
    print(result);
    expect(result, "26.45");
  });
}
