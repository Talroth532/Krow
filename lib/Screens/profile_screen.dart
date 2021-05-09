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
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  File _userImageFile;
  String _newUname = '';
  String _newPhone = '';

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  Future<bool> _trySubmit(
    Future<void> sendData(
      String username,
      String phone,
      File image,
    ),
  ) async {
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
      await sendData(
        _newUname,
        _newPhone,
        _userImageFile,
      );
      setState(() {
        isLoading = false;
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    User curUse = Provider.of<Users>(context).curUse;
    var _args = ModalRoute.of(context).settings.arguments as Map<String, bool>;
    bool isFind = _args['isFind'];
    Future<void> Function(
      String userName,
      String phone,
      File image,
    ) sendFn = Provider.of<Users>(context).updateUserData;

    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
          )
        : _isEdit
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
                body: Form(
                  key: _formKey,
                  child: Column(
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
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length > 15) {
                                return 'Please enter a valid UserName.';
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: TextFormField(
                            key: ValueKey('phone'),
                            validator: (value) {
                              if (value.isEmpty || value.length > 10) {
                                return 'Please enter a valid Phone Number.';
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
                      ),
                      RaisedButton(
                        onPressed: () async {
                          bool didChange = await _trySubmit(sendFn);
                          if (didChange) {
                            setState(() {
                              _isEdit = !(_isEdit);
                            });
                          }
                        },
                        child: Container(
                          child: Text('Save Changes'),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
                        Text(
                          'Username:\t' + curUse.username,
                          style: TextStyle(
                              backgroundColor: Colors.blue,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5 - 30,
                    ),
                    Text(
                      'Email:\t' + curUse.email,
                      style: TextStyle(
                          backgroundColor: Colors.blue,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Phone:\t' + curUse.phone,
                      style: TextStyle(
                          backgroundColor: Colors.blue,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
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
