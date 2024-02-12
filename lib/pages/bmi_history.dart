import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_moon/widgets/bmi_infocard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIHistory extends StatelessWidget {
  BMIHistory({super.key});
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(child: _dataCard());
  }

  Widget _dataCard() {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prefs = snapshot.data as SharedPreferences;
            final date = DateTime.parse(prefs.getString("bmi_date")!);
            final data = prefs.getStringList("bmi_data");
            return Center(
              child: InfoCard(
                  width: _deviceWidth * 0.75,
                  height: _deviceHeight * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data![1],
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "${date.day}/${date.month}/${date.year}",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        data[0],
                        style: TextStyle(fontSize: 60),
                      ),
                    ],
                  )),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(color: Colors.blue),
            );
          }
        });
  }
}
