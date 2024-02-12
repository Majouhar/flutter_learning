import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/services/firebase_service.dart';

class FinReg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegPageState();
  }
}

class _RegPageState extends State<FinReg> {
  double? screenWidth;
  String? email;
  String? password;
  String? name;
  File? image;
  FirebaseService? _firebaseService;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _profileImageWidget(),
          _inputBoxes(),
          _loginBtn(),
          _loginText()
        ],
      ),
    ));
  }

  Widget _title() {
    return const Text(
      "Finstagram",
      style: TextStyle(fontSize: 30),
    );
  }

  Widget _inputBoxes() {
    return SizedBox(
      height: 250,
      child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Name..."),
                onSaved: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  return value!.length > 3
                      ? null
                      : "Enter Name greater than 3 char";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Email..."),
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  bool result = value!.contains(
                      RegExp(r"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$"));
                  return result ? null : "Please Enter a Valid Email";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password..."),
                obscureText: true,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  return value!.length >= 6
                      ? null
                      : "Please Enter a Valid Password";
                },
              )
            ],
          )),
    );
  }

  Widget _loginBtn() {
    return MaterialButton(
      onPressed: () {
        _registerUser();
      },
      color: Colors.red,
      minWidth: screenWidth! * 0.8,
      child: const Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _loginText() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'login'),
      child: const Text(
        "Already have an account?",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  Widget _profileImageWidget() {
    var imageProvider = image != null
        ? FileImage(image!)
        : const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((value) {
          setState(() {
            image = File(value!.files.first.path!);
          });
        });
      },
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider as ImageProvider,
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    if (_registerFormKey.currentState!.validate() && image!=null) {
      _registerFormKey.currentState!.save();
      bool result = await _firebaseService!.registerUser(
          name: name!, email: email!, password: password!, file: image!);
      if (result) {
        Navigator.pop(context);
      }
    }
  }
}
