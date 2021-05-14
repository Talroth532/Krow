import 'package:flutter/material.dart';
import 'package:krow1/Widgets/home.dart';
import 'package:provider/provider.dart';

import './Screens/fav_job_screen.dart';
import './Providers/Fav.dart';
import './Screens/chats_screen.dart';
import './Screens/my_jobs.dart';
import './Providers/User.dart';
import './Screens/post_job_screen.dart';
import './Screens/job_screen.dart';
import './Screens/profile_screen.dart';
import './Screens/home_screen.dart';
import './Providers/Chats.dart';
import './Screens/auth_screen.dart';
import './Providers/Jobs.dart';
import './Screens/Jobs_screen.dart';
import './Screens/chat_screen.dart';

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
        ChangeNotifierProvider(create: (ctx) => Users()),
        ChangeNotifierProxyProvider<Users, Fav>(
          create: null,
          update: (ctx, user, _) => Fav(user.uid),
        ),
      ],
      child: MaterialApp(
        title: 'Krow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          fontFamily: 'Quicksand',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        routes: {
          AuthScreen.routName: (ctx) => AuthScreen(),
          HomeScreen.routName: (ctx) => HomeScreen(),
          JobsScreen.routeName: (ctx) => JobsScreen(),
          JobScreen.routeName: (ctx) => JobScreen(),
          ProfileScreen.routName: (ctx) => ProfileScreen(),
          PostJobScreen.routeName: (ctx) => PostJobScreen(),
          ChatsScreen.routeName: (ctx) => ChatsScreen(),
          MyJobScreen.routeName: (ctx) => MyJobScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          FavJobScreen.routeName: (ctx) => FavJobScreen(),
        },
      ),
    );
  }
}
