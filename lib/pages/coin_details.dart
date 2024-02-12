import 'package:flutter/material.dart';

class CoinDetails extends StatelessWidget {
  final String test;
  const CoinDetails({required this.test});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(test),
        ),
      ),
    );
  }
}
