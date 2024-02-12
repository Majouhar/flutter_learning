import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_moon/utils/calculator.dart';
import 'package:go_moon/widgets/bmi_infocard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  late double _deviceWidth, _deviceHeight;
  int _age = 25, _weight = 60, _height = 150, _gender = 0;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _countWidget(
                  const Key("age_add"), const Key("age_txt"), "Age yr", _age,
                  () {
                _age++;
              }, () {
                _age--;
              }),
              _countWidget(const Key("weight_add"), const Key("weight_txt"),
                  "Wright Kg", _weight, () {
                _weight++;
              }, () {
                _weight--;
              })
            ],
          ),
          _heightSelectWidget(),
          _genderSelectWidget(),
          _calculateBtn(),
        ],
      ),
    ));
  }

  Widget _heightSelectWidget() {
    return InfoCard(
        width: _deviceWidth * 90,
        height: _deviceHeight * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Height in cm",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              _height.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: _deviceWidth * 0.80,
              child: CupertinoSlider(
                  min: 100,
                  max: 250,
                  value: _height.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _height = value.toInt();
                    });
                  }),
            )
          ],
        ));
  }

  Widget _genderSelectWidget() {
    return InfoCard(
        width: _deviceWidth * 90,
        height: _deviceHeight * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Gender",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: _deviceWidth * 0.80,
              child: CupertinoSlidingSegmentedControl(
                  groupValue: _gender,
                  children: const {0: Text("Male"), 1: Text("Female")},
                  onValueChanged: (value) {
                    setState(() {
                      _gender = value as int;
                    });
                  }),
            )
          ],
        ));
  }

  Widget _countWidget(Key key, Key txtKey, String head, int count,
      void Function() addCalback, void Function() reduceCallback) {
    return InfoCard(
      width: _deviceWidth * 0.40,
      height: _deviceHeight * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            head,
            style: const TextStyle(fontSize: 15),
          ),
          Text(
            key: txtKey,
            count.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        reduceCallback();
                      });
                    },
                    child: const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    )),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                    key: key,
                    onPressed: () {
                      setState(() {
                        addCalback();
                      });
                    },
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _calculateBtn() {
    return Container(
      height: _deviceHeight * 0.07,
      child: CupertinoButton.filled(
          child: const Text('Calculate BMI'),
          onPressed: () {
            if (_weight > 0 && _height > 0) {
              double bmi = calculateBMI(_weight, _height);
              _showResultDialogue(bmi);
            }
          }),
    );
  }

  void _showResultDialogue(double bmi) {
    String? status;
    if (bmi < 18.5) {
      status = "Under Weight";
    } else if (bmi < 25) {
      status = "Normal";
    } else if (bmi < 30) {
      status = "Over Weight";
    } else {
      status = "Obese";
    }
    _saveResult(bmi.toStringAsFixed(2), status);
    showCupertinoDialog(
        context: context,
        builder: (dContext) {
          return CupertinoAlertDialog(
            title: Text(status!),
            content: Text(bmi.toStringAsFixed(2)),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(dContext);
                },
              )
            ],
          );
        });
  }

  void _saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    await prefs.setStringList('bmi_data', <String>[bmi, status]);
  }
}
