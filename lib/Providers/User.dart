import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  AuthResult _authresult;
  User _curUse;
  String _imageUrl;
  String _uid;
  User _idUser;
  List<User> _allUsers = [];

// טענת כניסה: הפעולה מקבלת מחרוזות: מייל, סיסמא, שם משתמש, טלפון, קובץ: תמונה, בוליאני: והאם המשתמש בהרשמה או כניסה
// טענת יציאה: הפעולה מחזירה מחרוזת שמסמלת את הטעות אם יש
// הסבר: הפעולה בודקת האם משתמש קיים אם המשתמש בכניסה ואם הוא בהרשמה, הפעולה יוצרת משתמש עם הפרטים שהוכנסו. בנוסף הפעולה מעדכנת את המשתנים הפרטיים בהתאם
  Future<String> submitAuthForm(
    String email,
    String password,
    String username,
    String phone,
    File image,
    bool isLogin,
  ) async {
    if (isLogin) {
      _authresult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      _authresult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(_authresult.user.uid + '.jpg');
      await ref.putFile(image).onComplete;

      _imageUrl = await ref.getDownloadURL();

      await Firestore.instance
          .collection('users')
          .document(_authresult.user.uid)
          .setData({
        'email': email,
        'username': username,
        'phone': phone,
        'url': _imageUrl,
      });
    }
    _uid = _authresult.user.uid;
    notifyListeners();
    return '';
  }

//טענת כניסה: הפעולה לא מקבלת משתנים
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מביאה מטבלת המשתמשים את הפרטים של כל המשתמשים ומכניסה אותם לרשימת כל המשתמשים
  Future<void> getAllUserData() async {
    print('getting all user data');
    var docSnapshot =
        await Firestore.instance.collection('users').getDocuments();
    var docs = docSnapshot.documents;
    for (int i = 0; i < docs.length; i++) {
      _allUsers.add(
        User(
            id: docs[i].documentID,
            email: docs[i]['email'],
            username: docs[i]['username'],
            phone: docs[i]['phone'],
            imageUrl: docs[i]['url']),
      );
    }
  }

// טענת כניסה: הפעולה לא מקבלת משתנים
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מביאה ממסד הנתונים את הפרטים של המשתמש הנוכחי ומכניסה אותם למשתנה הפרטי.
  Future<void> getCurrentUserData() async {
    print('getting user data');
    final curUser = await FirebaseAuth.instance.currentUser();
    final curUid = curUser.uid;
    var userSnapshot =
        await Firestore.instance.collection('users').document(curUid).get();
    var doc = userSnapshot.data;
    _curUse = User(
        id: curUid,
        email: doc['email'],
        username: doc['username'],
        phone: doc['phone'],
        imageUrl: doc['url']);
  }

  User get curUse {
    return this._curUse;
  }

// טענת כניסה: הפעולה לא מקבלת משתנים
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מנתקת את המשתמש הנוכחי
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

// טענת כניסה: הפעולה מקבלת מזהה של משתמש
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מכניסה את פרטי המשתמש למשתנה הפרטי משתמש מזהה
  void getIdUser(String id) {
    for (int i = 0; i < this._allUsers.length; i++) {
      if (_allUsers[i].id == id) {
        _idUser = _allUsers[i];
        break;
      }
    }
  }

  User get idUser {
    return this._idUser;
  }

// טענת כניסה: הפעולה מקבל מחרוזת
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מעדכנת את המזהה של המשתמש הנוכחי עם המזהה שמתקבל
  void refreshUserData(String uid) {
    this._uid = uid;
    notifyListeners();
  }

// טענת כניסה: הפעולה מקבלת שם משתמש, טלפון ותמונה
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מעדכנת את פרטי המשתמש הנוכחי במסד הנתונים ובמשתנה הפרטי לפרטים שהוכנסו לפעולה
  Future<void> updateUserData(
    String username,
    String phone,
    File image,
  ) async {
    final ref = FirebaseStorage.instance.ref().child('user_image').child(
          _uid + '.jpg',
        );
    await ref.delete();
    await ref.putFile(image).onComplete;
    final url = await ref.getDownloadURL();

    Firestore.instance.collection('users').document(_uid).setData({
      'email': curUse.email,
      'username': username,
      'phone': phone,
      'url': url
    });
    _curUse = User(
        id: _uid,
        email: curUse.email,
        imageUrl: url,
        phone: phone,
        username: username);
  }

  String get uid {
    return this._uid;
  }

  List<User> get allUsers {
    return this._allUsers;
  }
}
