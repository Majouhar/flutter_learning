import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_moon/pages/bmi_history.dart';
import 'package:go_moon/pages/bmi_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> tabs = [const BMIPage(), BMIHistory()];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("IBMI"),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: "BMI"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: "History")
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(builder: (context) => tabs[index]);
        },
      ),
    );
  }
}
