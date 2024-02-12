import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/services/firebase_service.dart';

class FinProfile extends StatefulWidget {
  const FinProfile({super.key});

  @override
  State<FinProfile> createState() => _FinProfileState();
}

class _FinProfileState extends State<FinProfile> {
  late FirebaseService _firebaseService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_profileWidget(),_postGridView() ],
      ),
    );
  }

  Widget _profileWidget() {
    _firebaseService.getLatestPostofUser();
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_firebaseService.currentUser!["image"]))),
    );
  }

  Widget _postGridView() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService.getLatestPostofUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                List posts = snapshot.data!.docs.map((e) => e.data()).toList();
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      Map post = posts[index];
                      return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    post["image"],
                                  ))));
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
