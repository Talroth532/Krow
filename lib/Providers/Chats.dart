import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';
import '../models/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chats;

// טענת כניסה: הפעולה לא מקבלת ערכים.
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה ניגשת למסד הנתונים, לטבלת הצ'אטים ועוברת על ערכי הטבלה. כל ערך היא מכניסה לתוך משנתה מסוג רשימה של צ'אטים ובסוף הפעולה מכניסה את המשתנה לתוך המשתנה הפרטי של צ'אטים
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

// טענת כניסה: הפעולה מקבלת מזהה של צ'אט
// טענת יציאה: הפעולה מחזירה סטרים של רשימה של הודעות
// הסבר: הפעולה ניגשת לטבלת ההודעות בצ'אט שהפעולה קיבלה את המזהה שלו ויוצרת קשר ישיר בעזרת סטרים עם טבלת ההודעות שמתעדכנת כל פעם שהטבלה מתעדנת
  Stream<List<Message>> fetchMessages(String chatId) {
    return Firestore.instance
        .collection('chats')
        .document(chatId)
        .collection('messages')
        .orderBy('date', descending: false)
        .snapshots()
        .map(
      (list) {
        return list.documents.map(
          (doc) {
            return Message(
              id: doc.documentID,
              text: doc['text'],
              posterId: doc['posterId'],
              date: doc['date'],
            );
          },
        ).toList();
      },
    );
  }

  // טענת כניסה: הפעולה מקבלת מזהה של שני משתמשים
  // טענת יציאה: הפעולה לא מחזירה כלום
  // הסבר: הפעולה יוצרת ערך חדש בטבלת הצ'אטים במסד הנתונים ויוצרת מופע חדש של צ'אט ומחניסה אותו למשתנה הפרטי צ'אטים.
  Future<void> createNewChat(String uid1, String uid2) async {
    var doc = await Firestore.instance
        .collection('chats')
        .add({'uid1': uid1, 'uid2': uid2});
    var docid = doc.documentID;
    _chats.add(
      Chat(
        uid1: uid1,
        uid2: uid2,
        id: docid,
      ),
    );
    notifyListeners();
  }

// טענת כניסה: הפעולה מקבלת מזהה של צ'אט, מזהה של משתמש ומחרוזת.
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה יוצרת ערך חדש עם ההודעה שניכנסת לפעולה ומזהה המשתמש בטבלת ההודעות שבערך של המזהה של הצ'אט שהוכנס.
  Future<void> sendMessage(String cid, String uid, String enterdMessage) async {
    Firestore.instance
        .collection('chats')
        .document(cid)
        .collection('messages')
        .add({
      'posterId': uid,
      'text': enterdMessage,
      'date': Timestamp.now(),
    });
  }

  // טענת כניסה: הפעולה מקבלת מזהה של צ'אט
  // טענת יציאה: הפעולה לא מחזירה כלום
  // הסבר: הפעולה מוחקת את הצ'אט שהמזהה שלו היא מקבלת ממסד הנתונים ומהמשתנה הפרטי
  Future<void> removeChat(String cid) async {
    await Firestore.instance.collection('chats').document(cid).delete();
    _chats.removeWhere((element) => element.id == cid);
    notifyListeners();
  }

  // טענת כניסה: הפעולה מקבלת מזהה של צ'אט ושל הודעה
  // טענת יציאה: הפעולה לא מחזירה כלום
  // הסבר: הפעולה מוחקת את ההודעה בצ'אט במסד הנתונים
  Future<void> removeMessage(String cid, String mid) async {
    await Firestore.instance
        .collection('chats')
        .document(cid)
        .collection('messages')
        .document(mid)
        .delete();
  }
}
