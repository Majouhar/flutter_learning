import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final double width,height;
  const InfoCard({super.key, required this.width,required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                )
              ]),
          width:width ,
          height:height,
          child: child,
        ),
      ),
    );
  }
}