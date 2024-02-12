import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/services/firebase_service.dart';

class FinLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegPageState();
  }
}

class _RegPageState extends State<FinLogin> {
  double? screenWidth;
  String? email;
  String? password;
  FirebaseService? _firebaseService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }


  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildUI(),
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
        children: [_title(), _inputBoxes(), _loginBtn(), _signUpText()],
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
      height: 200,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
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
        _loginUser();
      },
      color: Colors.red,
      minWidth: screenWidth! * 0.8,
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _signUpText() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool result = await _firebaseService!.loginUser(email: email!, password: password!);
      if(result){
        Navigator.popAndPushNamed(context, 'home');
      }else{

      }
    }
  }
}
