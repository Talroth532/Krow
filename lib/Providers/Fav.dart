import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userJob.dart';
import '../models/job.dart';

class Fav with ChangeNotifier {
  String uid;
  List<UserJob> userJobs = [];

  Fav(this.uid);

  Future<void> fetchUidFavStatus() async {
    var favSnapshot = await Firestore.instance
        .collection('user-job')
        .where('uid', isEqualTo: uid)
        .getDocuments();
    var docs = favSnapshot.documents;
    for (int i = 0; i < docs.length; i++) {
      userJobs.add(
        UserJob(
          id: docs[i].documentID,
          uid: uid,
          jobId: docs[i]['job id'],
        ),
      );
    }
  }

  Future<void> createNewFav(
    String uid,
    String jobId,
  ) async {
    var document = await Firestore.instance.collection('user-job').add({
      'uid': uid,
      'job id': jobId,
    });
    userJobs.add(UserJob(
      id: document.documentID,
      uid: uid,
      jobId: jobId,
    ));
  }

  Future<void> updateStatus(
    String uid,
    String jobId,
  ) async {
    int i;
    bool exists;
    var favSnapshot =
        await Firestore.instance.collection('user-job').getDocuments();
    var docs = favSnapshot.documents;
    for (i = 0; i < docs.length; i++) {
      if (docs[i]['uid'] == uid && docs[i]['job id'] == jobId) {
        exists = true;
        break;
      } else {
        exists = false;
      }
    }
    if (exists) {
      int index = userJobs.indexWhere((element) {
        return (element.uid == uid && element.jobId == jobId);
      });
      await Firestore.instance
          .collection('user-job')
          .document(docs[i].documentID)
          .delete();
    } else {
      createNewFav(uid, jobId);
    }
  }

  bool checkIfExist(Job job) {
    if (this.userJobs.firstWhere((element) {
          return element.jobId == job.id;
        }, orElse: () => null) !=
        null) {
      return true;
    } else
      return false;
  }
}
