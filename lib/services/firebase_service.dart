import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();
  Map? currentUser;
  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        currentUser = await getUserData(uuid: userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUser(
      {required String name,
      required String email,
      required String password,
      required File file}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String _userId = user.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(file.path);
      print("START $fileName");
      UploadTask task =
          _storage.ref().child('images/$_userId/$fileName').putFile(file);
      await task;
      print("DONE ${task.snapshot.ref}");
      String downloadURL = await task.snapshot.ref.getDownloadURL();
      await _db
          .collection('users')
          .doc(_userId)
          .set({"name": name, "email": email, "image": downloadURL});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uuid}) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uuid).get();
    return doc.data() as Map;
  }

  Future<bool> postImage(File file) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = userId +
          Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(file.path);
      UploadTask task = _storage.ref().child('posts/$fileName').putFile(file);
      return task.then((p0) async {
        String downloadURL = await p0.ref.getDownloadURL();
        await _db.collection('posts').add({
          "userId": userId,
          "timestamp": Timestamp.now(),
          "image": downloadURL
        });
        return true;
      }).catchError((e) {
        return false;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPostofUser() {
    return _db
        .collection('posts')
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
