import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../Screens/auth_screen.dart';
import '../Screens/home_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (ctx, snapshot) {
        var user = snapshot.data;
        if (user != null) {
          Provider.of<Users>(context).refreshUserData(user.uid);
          return HomeScreen();
        }
        return AuthScreen();
      },
    );
  }
}
