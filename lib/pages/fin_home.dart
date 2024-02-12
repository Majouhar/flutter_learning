import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/pages/fin_feed.dart';
import 'package:go_moon/pages/fin_profile.dart';
import 'package:go_moon/services/firebase_service.dart';

class FinHome extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _FinHomeState();
  }
}

class _FinHomeState extends State<FinHome> {
  int currentPage = 0;
  FirebaseService? _firebaseService;
  final List<Widget> pages = const [FinFeed(), FinProfile()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finstagram",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                _postImage();
              },
              child: const Icon(Icons.add_a_photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () async {
                await _firebaseService!.logout();
                Navigator.popAndPushNamed(context, 'login');
              },
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: pages[currentPage],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Feed",
            icon: Icon(
              Icons.feed,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.account_box,
            ),
          )
        ]);
  }

  void _postImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File file = File(result!.files.first.path!);
    await _firebaseService!.postImage(file);
  }
}
