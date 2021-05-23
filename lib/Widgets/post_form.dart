import 'dart:io';
import 'package:flutter/material.dart';

import 'user_image_picker.dart';

class PostForm extends StatefulWidget {
  final Function(
    String title,
    String description,
    String imageUrl,
    String payment,
    String posterId,
    File image,
  ) sendFunction;
  String posterId;
  PostForm(this.sendFunction, this.posterId);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _description = '';
  var _imageUrl = '';
  var _payment = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

// טענת כניסה: הפעולה לא מקבלת משתנים
// טענת יציאה: הפעולה מחזירה ערך בוליאני
// הסבר: הפעולה בודקת את הנתונים שהוכנסו לתיבות הטקסט ואם הם מאושרים אז הפעולה של העלאת עבודה של הפרובידר רצה והפעולה מחזירה נכון ואם לא, הפעולה מחזירה לא נכון
  Future<bool> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick a valid image'),
          backgroundColor: Colors.red,
        ),
      );
      return true;
    }

    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      await widget.sendFunction(
        _title.trim(),
        _description.trim(),
        _imageUrl.trim(),
        _payment.trim(),
        widget.posterId,
        _userImageFile,
      );
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Job Posted'),
          backgroundColor: Colors.blue,
        ),
      );
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ))
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  UserImagePicker(_pickedImage),
                  Padding(
                    padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
                    child: TextFormField(
                      key: ValueKey('title'),
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 4 ||
                            value.length > 15) {
                          return 'Please enter a valid title.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      onSaved: (value) {
                        _title = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
                    child: TextFormField(
                      key: ValueKey('description'),
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 10 && value.length > 50) {
                          return 'Please enter a valid description.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      onSaved: (value) {
                        _description = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
                    child: TextFormField(
                      key: ValueKey('payment'),
                      validator: (value) {
                        if (value.isEmpty || value.length > 10) {
                          return 'Please enter a valid payment amount.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Payment per hour',
                      ),
                      onSaved: (value) {
                        _payment = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text('Post'),
                      onPressed: () async {
                        await _trySubmit();
                      },
                      color: Colors.lightBlue,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
