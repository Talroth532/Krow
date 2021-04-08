import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../models/user.dart';

class User with ChangeNotifier {
  AuthResult authresult;
  Users curUse;
  String imageUrl;
  String uid;

  Future<String> submitAuthForm(
    String email,
    String password,
    String username,
    String phone,
    File image,
    bool isLogin,
    bool _isLoading,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
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
        final url = ref.getDownloadURL().toString();

        await ref.putFile(image).onComplete;

        await Firestore.instance
            .collection('users')
            .document(authresult.user.uid)
            .setData({
          'email': email,
          'username': username,
          'phone': phone,
          'url': url,
        });
        return '';
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, plese check your credentials';

      if (err.message != null) {
        message = err.message;
      }

      _isLoading = false;
      notifyListeners();
      return message;
    } catch (err) {
      print(err);
      _isLoading = false;
      notifyListeners();
      return err;
    }
  }

  Future<void> getCurrentUserData() async {
    print('getting user data');
    final curUser = await FirebaseAuth.instance.currentUser();
    final curUid = curUser.uid;
    var userSnapshot =
        await Firestore.instance.collection('users').document(curUid).get();
    var doc = userSnapshot.data;
    curUse = Users(
        email: doc['email'],
        username: doc['username'],
        phone: doc['phone'],
        imageUrl: doc['imageUrl']);
  }

  Future<String> getCurrentUid() async {
    var user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
    return uid;
  }

  String get userid {
    return this.uid;
  }

  Users get currentUser {
    return this.curUse;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
