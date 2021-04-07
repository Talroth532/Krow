import 'package:flutter/foundation.dart';

class Chat {
  String uid1;
  String uid2;
  List<String> messages;

  Chat({
    @required this.uid1,
    @required this.uid2,
    @required this.messages,
  });
}
