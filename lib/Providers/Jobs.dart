import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/job.dart';

class Jobs with ChangeNotifier {
  List<Job> _jobs = [];

// טענת כניסה: הפעולה לא מקבלת ערכים.
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה ניגשת למסד הנתונים, לטבלת העבודות ועוברת על ערכי הטבלה. כל ערך היא מכניסה לתוך משנתה מסוג רשימה של עבודות ובסוף הפעולה מכניסה את המשתנה לתוך המשתנה הפרטי של עבודות
  Future<void> fetchAndSetJobs() async {
    print('fetching jobs... ');
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

// טענת כניסה: הפעולה מקבלת שם עבודה, תיאור עבודה, כתובת תמונת עבודה, תשלום עבודה, מזהה מפרסם העבודה ותמונה
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה יוצרת ערך חדש בטבלת עבודות עם הערכים שהיא מקבלת ומצרפת את העבודה החדשה למשתנה הפרטי
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
    await ref.putFile(image).onComplete;

    imageUrl = await ref.getDownloadURL();

    doc.setData({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'payment': payment,
      'posterId': posterId
    });
    _jobs.add(Job(
        id: doc.documentID,
        title: title,
        description: description,
        imageUrl: imageUrl,
        payment: payment,
        posterId: posterId));
  }

// טענת כניסה: הפעולה מקבלת מזהה עבודה
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מוחקת את העבודה ממסד הנתונים ומהמשתנה הפרטי
  Future<void> removeJob(String jobId) async {
    await Firestore.instance.collection('jobs').document(jobId).delete();
    for (int i = 0; i < _jobs.length; i++) {
      if (_jobs[i].id == jobId) {
        _jobs.removeAt(i);
      }
    }
  }
}
