import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userJob.dart';

class Fav with ChangeNotifier {
  String uid;
  List<UserJob> userJobs = [];

  Fav(this.uid);

  Future<void> fetchUidFavStatus() async {
    var favSnapshot =
        await Firestore.instance.collection('user-job').getDocuments();
    var docs = favSnapshot.documents;
    for (int i = 0; i < docs.length; i++) {
      if (docs[i]['uid'] == this.uid) {
        userJobs.add(
          UserJob(
            id: docs[i].documentID,
            uid: uid,
            jobId: docs[i]['job id'],
            isFav: docs[i]['favorite'],
          ),
        );
      }
    }
  }

  Future<void> createNewFav(String uid, String jobId, bool isFav) async {
    var document = await Firestore.instance.collection('user-job').add({
      'uid': uid,
      'job id': jobId,
      'favorite': isFav,
    });
    userJobs.add(UserJob(
      id: document.documentID,
      uid: uid,
      jobId: jobId,
      isFav: isFav,
    ));
  }

  Future<void> updateStatus(String uid, String jobId, bool newFav) async {
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
      userJobs[index].isFav = newFav;
      await Firestore.instance
          .collection('user-job')
          .document(docs[i].documentID)
          .setData({
        'favorite': newFav,
        'uid': uid,
        'job id': jobId,
      });
    } else {
      createNewFav(uid, jobId, newFav);
    }
  }
}
