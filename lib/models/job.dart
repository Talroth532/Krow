import 'package:flutter/foundation.dart';

class Job {
  String title;
  String description;
  String imageUrl;
  String payment;
  String posterId;

  Job(
      {@required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.payment,
      @required this.posterId});
}
