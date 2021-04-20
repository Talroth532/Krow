import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../models/job.dart';

class Jobs with ChangeNotifier {
  List<Job> _jobs = [];

  Future<void> fetchAndSetJobs() async {
    print('fetching items... by avnon');
    var jobSnapshot =
        await Firestore.instance.collection('jobs').getDocuments();
    var docs = jobSnapshot.documents;
    List<Job> jobs = List<Job>.generate(docs.length, (index) {
      return Job(
          id: docs[index].documentID,
          title: docs[index]['title'],
          description: docs[index]['description'],
          imageUrl: docs[index]['imageUrl'],
          payment: docs[index]['payment'],
          posterId: docs[index]['posterId']);
    });
    _jobs = jobs;
    notifyListeners();
  }

  List<Job> get jobs {
    return [..._jobs];
  }

  Future<void> uploadJob(String title, String description, String imageUrl,
      String payment, String posterId, File image) async {
    var doc = await Firestore.instance.collection('jobs').add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'payment': payment,
      'posterId': posterId,
    });
    notifyListeners();

    final ref = FirebaseStorage.instance
        .ref()
        .child('job_image')
        .child(doc.documentID + '.jpg');

    ref.putFile(image);
  }
}
