import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../models/user.dart';

class Users with ChangeNotifier {
  AuthResult authresult;
  User curUse;
  String imageUrl;
  String uid;
  User idUser;

  Future<String> submitAuthForm(
    String email,
    String password,
    String username,
    String phone,
    File image,
    bool isLogin,
  ) async {
    if (isLogin) {
      authresult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      authresult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authresult.user.uid + '.jpg');
      await ref.putFile(image).onComplete;

      imageUrl = await ref.getDownloadURL();

      uid = authresult.user.uid;

      await Firestore.instance
          .collection('users')
          .document(authresult.user.uid)
          .setData({
        'email': email,
        'username': username,
        'phone': phone,
        'url': imageUrl,
      });
    }
    return '';
  }

  Future<void> getCurrentUserData() async {
    print('getting user data');
    final curUser = await FirebaseAuth.instance.currentUser();
    final curUid = curUser.uid;
    var userSnapshot =
        await Firestore.instance.collection('users').document(curUid).get();
    var doc = userSnapshot.data;
    curUse = User(
        id: curUid,
        email: doc['email'],
        username: doc['username'],
        phone: doc['phone'],
        imageUrl: doc['url']);
  }

  User get currentUser {
    return this.curUse;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> getIdUser(String id) async {
    var usrsp = await Firestore.instance.collection('users').document(id).get();
    this.idUser = User(
      id: id,
      email: usrsp.data['email'],
      username: usrsp.data['username'],
      imageUrl: usrsp.data['Url'],
      phone: usrsp.data['phone'],
    );
  }

  User get userWithId {
    return this.idUser;
  }

  void refreshUserData(String uid) {
    this.uid = uid;
  }
}
