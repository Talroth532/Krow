import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chats;

  Future<void> fetchAndSetChats() async {
    print('fetching chats...');
    var chatSnapshot =
        await Firestore.instance.collection('chats').getDocuments();
    var docs = chatSnapshot.documents;
    List<Chat> chats = List<Chat>.generate(docs.length, (index) {
      return Chat(
        uid1: docs[index]['uid1'],
        uid2: docs[index]['uid2'],
        messages: docs[index]['messages'],
      );
    });
    _chats = chats;
    notifyListeners();
  }

  List<Chat> get chats {
    return [..._chats];
  }
}
