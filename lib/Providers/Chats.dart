import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/messages.dart';
import '../models/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chats;
  List<Message> _messages;

  Future<void> fetchAndSetChats() async {
    print('fetching chats...');
    var chatSnapshot =
        await Firestore.instance.collection('chats').getDocuments();
    var docs = chatSnapshot.documents;

    List<Chat> chats = List<Chat>.generate(docs.length, (index) {
      return Chat(
        id: docs[index].documentID,
        uid1: docs[index]['uid1'],
        uid2: docs[index]['uid2'],
      );
    });
    _chats = chats;
    notifyListeners();
  }

  List<Chat> get chats {
    return [..._chats];
  }

  Future<void> fetchMessages(String chatId) async {
    var messagesSnapshot = await Firestore.instance
        .collection('chats')
        .document(chatId)
        .collection('messages')
        .getDocuments();
    var messagesDocs = messagesSnapshot.documents;
    _messages = List<Message>.generate(messagesDocs.length, (index) {
      return Message(
        text: messagesDocs[index]['text'],
        posterId: messagesDocs[index]['posterId'],
      );
    });
    notifyListeners();
  }

  Future<void> createNewChat(String uid1, String uid2) async {
    var doc = await Firestore.instance
        .collection('chats')
        .add({'uid1': uid1, 'uid2': uid2});
    var docid = doc.documentID;
    chats.add(Chat(
      uid1: uid1,
      uid2: uid2,
      messages: [],
      id: docid,
    ));
    notifyListeners();
  }

  List<Message> get messages {
    return [..._messages];
  }
}
