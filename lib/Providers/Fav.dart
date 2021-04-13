import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fav with ChangeNotifier {
  bool isFav;

  Future<void> checkFavStatus(String uid, String jobId) async {
    int i;
    var favSnapshot =
        await Firestore.instance.collection('user-job').getDocuments();
    var docs = favSnapshot.documents;
    for (i = 0; i < docs.length; i++) {
      if (docs[i]['uid'] == uid && docs[i]['job id'] == jobId) {
        this.isFav = docs[i]['favorite'];
        break;
      } else {
        this.isFav = false;
      }
    }
  }

  Future<void> createNewFav(String uid, String jobId, bool isFav) async {
    await Firestore.instance.collection('user-job').add({
      'uid': uid,
      'job id': jobId,
      'favorite': isFav,
    });
  }

  Future<void> updateStatus(String uid, String jobId, bool isFav) async {
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
      await Firestore.instance
          .document(docs[i].documentID)
          .setData({'favorite': isFav});
    } else {
      createNewFav(uid, jobId, isFav);
    }
  }
}
