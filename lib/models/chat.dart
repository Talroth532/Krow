import 'package:flutter/foundation.dart';

import 'message.dart';

class Chat {
  String id;
  String uid1;
  String uid2;
  List<Message> messages;

  Chat({
    this.id,
    @required this.uid1,
    @required this.uid2,
    this.messages,
  }); // Constructor
}
