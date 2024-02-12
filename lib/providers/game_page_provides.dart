import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List? questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  final String difficulty;
  BuildContext context;
  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    getQuestions();
  }
  Future<Response?> getQuestions() async {
    try {
      Response response = await _dio.get(
        "",
        queryParameters: {
          'amount': 3,
          'type': 'boolean',
          'difficulty': difficulty,
        },
      );
      var data = jsonDecode(
        response.toString(),
      );
      questions = data["results"];
      notifyListeners();
    } catch (e) {
      print("HttpService: get request failed");
      print(e);
    }
    return null;
  }

  String getCurrentQuestion() {
    return questions![_currentQuestionIndex]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_currentQuestionIndex]["correct_answer"] == answer;
    if (_currentQuestionIndex < 9) {
      _currentQuestionIndex++;
    }
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    if (isCorrect) {
      _score++;
    }
    Navigator.pop(context);
    if (_currentQuestionIndex > 2) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "Game Ended",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text(
              "Score $_score/3",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
