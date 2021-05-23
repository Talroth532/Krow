import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  String id;
  String text;
  String posterId;
  Timestamp date;

  Message({
    @required this.id,
    @required this.posterId,
    @required this.text,
    @required this.date,
  }); // Constructor
}
