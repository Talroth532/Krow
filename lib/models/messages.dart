import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String text;
  String posterId;
  Timestamp date;

  Message({
    this.id,
    this.posterId,
    this.text,
    this.date,
  });
}
