import 'package:flutter/foundation.dart';

class UserJob {
  String id;
  String uid;
  String jobId;
  bool isFav;

  UserJob({
    @required this.id,
    @required this.uid,
    @required this.jobId,
    @required this.isFav,
  });
}
