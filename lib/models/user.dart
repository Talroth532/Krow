import 'package:flutter/foundation.dart';

class User {
  String id;
  String email;
  String username;
  String phone;
  String imageUrl;

  User({
    @required this.id,
    @required this.email,
    @required this.username,
    @required this.phone,
    @required this.imageUrl,
  });
}
