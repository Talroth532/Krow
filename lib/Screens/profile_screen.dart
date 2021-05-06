import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:krow1/Widgets/post_drawer.dart';
import 'package:krow1/pickers/user_image_picker.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../Widgets/drawer_form.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  static const routName = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  File _userImageFile;
  String _newMail = '';
  String _newUname = '';
  String _newPhone = '';

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  // Future<bool> _trySubmit() async {
  //   final isValid = _formKey.currentState.validate();
  //   FocusScope.of(context).unfocus();

  //   if (_userImageFile == null) {
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please pick a valid image'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return true;
  //   }

  //   if (isValid) {
  //     _formKey.currentState.save();
  //     // setState(() {
  //     //   isLoading = true;
  //     // });
  //     await widget.sendFunction(
  //       _title.trim(),
  //       _description.trim(),
  //       _imageUrl.trim(),
  //       _payment.trim(),
  //       widget.posterId,
  //       _userImageFile,
  //     );
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Job Posted'),
  //         backgroundColor: Colors.blue,
  //       ),
  //     );
  //     return true;
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    User curUse = Provider.of<Users>(context).curUse;
    var _args = ModalRoute.of(context).settings.arguments as Map<String, bool>;
    bool isFind = _args['isFind'];

    return _isEdit
        ? Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            drawer: isFind
                ? null
                : Drawer(
                    child: PostDrawer(),
                  ),
            endDrawer: isFind
                ? Drawer(
                    child: DrawerForm(),
                  )
                : null,
            body: Container(
              height: 200,
              width: 200,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child: Container(
                            child: UserImagePicker(_pickedImage),
                            height: 100,
                            width: 100,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email address',
                            ),
                            onChanged: (value) {
                              _newMail = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onChanged: (value) {
                          _newUname = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        key: ValueKey('phone'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                        ),
                        onChanged: (value) {
                          _newPhone = value;
                        },
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // trySubmit();
                        setState(() {
                          _isEdit = !(_isEdit);
                        });
                      },
                      child: Container(
                        child: Text('Save Changes'),
                      ),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            drawer: isFind
                ? null
                : Drawer(
                    child: PostDrawer(),
                  ),
            endDrawer: isFind
                ? Drawer(
                    child: DrawerForm(),
                  )
                : null,
            body: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      child: Container(
                        child: Image.network(curUse.imageUrl),
                        height: 100,
                        width: 100,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    Text('Username:\t' + curUse.username),
                  ],
                ),
                Text('Email:\t' + curUse.email),
                Text('Phone:\t' + curUse.phone),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _isEdit = !(_isEdit);
                    });
                  },
                  child: Container(
                    child: Text('Edit Profile'),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
          );
  }
}
