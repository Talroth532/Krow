import 'package:flutter/material.dart';
import 'package:krow1/Screens/chats_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Providers/User.dart';
import './Screens/post_job_screen.dart';
import 'Screens/job_screen.dart';
import './Screens/profile_screen.dart';
import './Screens/home_screen.dart';
import './Providers/Chats.dart';
import './Screens/auth_screen.dart';
import './Providers/Jobs.dart';
import 'Screens/Jobs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Jobs()),
        ChangeNotifierProvider(create: (ctx) => Chats()),
        ChangeNotifierProvider(create: (ctx) => User()),
      ],
      child: MaterialApp(
        title: 'Krow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, AsyncSnapshot<FirebaseUser> spt) {
                    if (spt.data.uid != null)
                      Provider.of<User>(ctx).refreshUserData(spt.data.uid);
                    return HomeScreen();
                  });
            }
            return AuthScreen();
          },
        ),
        routes: {
          AuthScreen.routName: (ctx) => AuthScreen(),
          HomeScreen.routName: (ctx) => HomeScreen(),
          JobsScreen.routeName: (ctx) => JobsScreen(),
          JobScreen.routeName: (ctx) => JobScreen(),
          ProfileScreen.routName: (ctx) => ProfileScreen(),
          PostJobScreen.routeName: (ctx) => PostJobScreen(),
          ChatsScreen.routename: (ctx) => ChatsScreen(),
        },
      ),
    );
  }
}
