import 'package:flutter/foundation.dart';

class Chat {
  String id;
  String uid1;
  String uid2;
  List<String> messages;

  Chat({
    this.id,
    @required this.uid1,
    @required this.uid2,
    this.messages,
  });
}
