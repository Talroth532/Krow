import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text;
  String posterId;
  Timestamp date;

  Message({
    this.posterId,
    this.text,
    this.date,
  });
}
