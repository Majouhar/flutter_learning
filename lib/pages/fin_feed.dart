import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/services/firebase_service.dart';

class FinFeed extends StatefulWidget {
  const FinFeed({super.key});

  @override
  State<FinFeed> createState() => _FinFeedState();
}

class _FinFeedState extends State<FinFeed> {
  double? _deviceHeight, _deviceWidth;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _deviceWidth,
      height: _deviceHeight,
      child: _postListView(),
    );
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseService.getLatestPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List _posts = snapshot.data.docs.map((e) => e.data()).toList();
          
            return ListView.builder(
                itemCount: _posts.length ,
                itemBuilder: (BuildContext context, int index) {
                  Map _post = _posts[index];
                  return Container(
                    height: _deviceHeight! * 0.30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(_post["image"]))),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
