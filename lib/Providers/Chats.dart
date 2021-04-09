import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/messages.dart';
import '../models/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chats;
  List<Message> messages;

  Future<void> fetchAndSetChats() async {
    print('fetching chats...');
    var chatSnapshot =
        await Firestore.instance.collection('chats').getDocuments();
    var docs = chatSnapshot.documents;

    List<Chat> chats = List<Chat>.generate(docs.length, (index) {
      return Chat(
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
    messages = List<Message>.generate(messagesDocs.length, (index) {
      return Message(
        text: messagesDocs[index]['text'],
        posterId: messagesDocs[index]['posterId'],
      );
    });
    notifyListeners();
  }
}
