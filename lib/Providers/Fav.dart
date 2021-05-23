import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userJob.dart';
import '../models/job.dart';

class Fav with ChangeNotifier {
  String uid;
  List<UserJob> _userJobs = [];

  Fav(this.uid);

// טענת כניסה: הפעולה לא מקבלת ערכים.
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה ניגשת למסד הנתונים, לטבלת היוזר-ג'ובס ועוברת על ערכי הטבלה. כל ערך היא מכניסה לתוך המשתנה הפרטי מסוג רשימה של יוזר-גובס
  Future<void> fetchUidFavStatus() async {
    var favSnapshot = await Firestore.instance
        .collection('user-job')
        .where('uid', isEqualTo: uid)
        .getDocuments();
    var docs = favSnapshot.documents;
    for (int i = 0; i < docs.length; i++) {
      _userJobs.add(
        UserJob(
          id: docs[i].documentID,
          uid: uid,
          jobId: docs[i]['job id'],
        ),
      );
    }
  }

// טענת כניסה: הפעולה מקבלת מזהה של עבודה.
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה יוצרת ערך חדש בטבלה ובמשתנה הפרטי עם המזהה של המשתמש ומזהה העבודה שמתקבלת בטענת הכניסה.
  Future<void> createNewFav(
    String jobId,
  ) async {
    var document = await Firestore.instance.collection('user-job').add(
      {
        'uid': uid,
        'job id': jobId,
      },
    );
    _userJobs.add(
      UserJob(
        id: document.documentID,
        uid: uid,
        jobId: jobId,
      ),
    );
  }

// טענת כניסה: הפעולה מקבלת מזהה של עבודה
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה בודקת במסד הנתונים אם קיים ערך עם המזהה של העבודה והמשתמש. אם קיים, הערך נמחק מהמסד נתונים ומהמשתנה הפרטי. אם לא, הפעולה מזמנת את הפעולה קרייט ניו פאב
  Future<void> updateStatus(
    String jobId,
  ) async {
    int i;
    bool exists = false;
    var favSnapshot =
        await Firestore.instance.collection('user-job').getDocuments();
    var docs = favSnapshot.documents;
    for (i = 0; i < docs.length; i++) {
      if (docs[i]['uid'] == uid && docs[i]['job id'] == jobId) {
        exists = true;
        break;
      }
    }
    if (exists) {
      int index = _userJobs.indexWhere(
        (element) {
          return (element.uid == uid && element.jobId == jobId);
        },
      );
      if (index == -1) {
        createNewFav(jobId);
      } else {
        await Firestore.instance
            .collection('user-job')
            .document(docs[i].documentID)
            .delete();
        _userJobs.removeAt(index);
      }
    } else {
      await createNewFav(jobId);
    }
  }

// טענת כניסה: הפעולה מקבלת עבודה
// טענת יציאה: הפעולה מחזירה ערך בוליאני
// הסבר: הפעולה בודקת העם קיים ערך במשתנה הפרטי עם העבודה שמתקבלת. אם קיים, הפעולה מחזירה נכון ואם לא הפעולה מחזירה לא נכון
  bool checkIfExist(Job job) {
    if (this._userJobs.firstWhere((element) {
          return element.jobId == job.id;
        }, orElse: () => null) !=
        null) {
      return true;
    } else
      return false;
  }

// טענת כניסה: הפעולה מקבלת מזהה עבודה
// טענת יציאה: הפעולה לא מחזירה כלום
// הסבר: הפעולה מוחקת את כל הערכים הקשורים לעבודה שמתקבלת ממסד הנתונים ומהמשתנה הפרטי
  Future<void> removeJob(String jobId) async {
    var documents =
        await Firestore.instance.collection('user-job').getDocuments();
    var docs = documents.documents;
    for (int i = 0; i < docs.length; i++) {
      if (docs[i]['job id'] == jobId) {
        await Firestore.instance
            .collection('user-job')
            .document(docs[i].documentID)
            .delete();
      }
      if (_userJobs[i].jobId == jobId) {
        _userJobs.removeAt(i);
      }
    }
  }

  List<UserJob> get userJobs {
    return [..._userJobs];
  }
}
