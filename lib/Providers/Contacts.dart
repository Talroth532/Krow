import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat.dart';
import '../models/user.dart';

class Contacts with ChangeNotifier {
  String uid;
  List<User> _contacts = [];

  Contacts(this.uid);

  Future<void> fetchAndSetContacts() async {
    var myChatSnapshot =
        await Firestore.instance.collection('chats').getDocuments();
    var docs = myChatSnapshot.documents;
    List<Chat> myChats = [];
    for (int i = 0; i < docs.length; i++) {
      if (docs[i]['uid1'] == uid || docs[i]['uid2'] == uid) {
        myChats.add(
          Chat(
            uid1: docs[i]['uid1'],
            uid2: docs[i]['uid2'],
          ),
        );
      }
    }
    DocumentSnapshot contact;
    for (int i = 0; i < myChats.length; i++) {
      if (myChats[i].uid1 == uid) {
        contact = await Firestore.instance
            .collection('users')
            .document(myChats[i].uid2)
            .get();
        _contacts.add(User(
            id: myChats[i].uid2,
            email: contact['email'],
            username: contact['username'],
            phone: contact['phone'],
            imageUrl: contact['url']));
      } else if (myChats[i].uid2 == uid) {
        contact = await Firestore.instance
            .collection('users')
            .document(myChats[i].uid1)
            .get();
        _contacts.add(User(
            id: myChats[i].uid1,
            email: contact['email'],
            username: contact['username'],
            phone: contact['phone'],
            imageUrl: contact['url']));
      }
    }
  }

  List<User> get contacts {
    return [..._contacts];
  }
}
