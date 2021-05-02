import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krow1/Screens/home_screen.dart';
import 'dart:io';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
  );

  final Future<String> Function(
    String email,
    String password,
    String userName,
    String phone,
    File image,
    bool isLogin,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userPhone = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick a valid image'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (isValid) {
      _formKey.currentState.save();
      try {
        setState(() {
          isLoading = true;
        });
        await widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _userPhone.trim(),
          _userImageFile,
          _isLogin,
        );
        setState(() {
          isLoading = false;
        });
      } on PlatformException catch (err) {
        var message = 'An error occured, plese check your credentials';

        if (err.message != null) {
          message = err.message;
        }
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      } catch (err) {
        print(err);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Krow'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!_isLogin) UserImagePicker(_pickedImage),
                          TextFormField(
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
                            onSaved: (value) {
                              _userEmail = value;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              key: ValueKey('username'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Please enter at least 4 characters';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Username'),
                              onSaved: (value) {
                                _userName = value;
                              },
                            ),
                          TextFormField(
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            onSaved: (value) {
                              _userPassword = value;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              key: ValueKey('phone'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a Phone number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                              ),
                              onSaved: (value) {
                                _userPhone = value;
                              },
                            ),
                          SizedBox(height: 12),
                          RaisedButton(
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                            onPressed: () {
                              _trySubmit();
                            },
                          ),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(_isLogin
                                ? 'Create new account'
                                : 'I already have an account'),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
