import 'package:flutter/material.dart';

class CustomDropDownClass extends StatelessWidget{
  List<String> values;
  double width;
  CustomDropDownClass({required this.values, required this.width,Key? key}) :super(key:key);


  @override
  Widget build(BuildContext context) {
    return  Container(
        width: width,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(53, 53, 54, 1),
            borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton(
          value: values.first,
          underline: Container(),
          items: values.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (_) {},
          dropdownColor: const Color.fromRGBO(53, 53, 53, 1),
          style: const TextStyle(color: Colors.white),
        ));
 
  }}