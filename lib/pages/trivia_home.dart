import 'package:flutter/material.dart';
import 'package:go_moon/pages/game_page.dart';

class TriviaHomePage extends StatefulWidget {
  TriviaHomePage();
  @override
  State<StatefulWidget> createState() {
    return _TriviaHomePageState();
  }
}

class _TriviaHomePageState extends State<TriviaHomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficulty = 0;
  final List<String> diffList = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Trivia",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            diffList[_currentDifficulty.toInt()],
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Slider(
              value: _currentDifficulty,
              min: 0,
              max: 2,
              divisions: 2,
              onChanged: (value) {
                setState(() {
                  _currentDifficulty = value;
                });
              }),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => GamePage(
                            difficulty: diffList[_currentDifficulty.toInt()]
                                .toLowerCase(),
                          ))));
            },
            color: Colors.blueAccent,
            child: const Text("Start"),
          )
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
