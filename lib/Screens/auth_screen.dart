import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../Widgets/auth_form.dart';
import '../Providers/User.dart';

class AuthScreen extends StatefulWidget {
  static const routName = '/AuthScreen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    Function _submitAuthForm = Provider.of<Users>(context).submitAuthForm;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AuthForm(
        _submitAuthForm,
      ),
    );
  }
}
