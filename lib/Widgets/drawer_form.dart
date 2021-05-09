import 'package:flutter/material.dart';
import 'package:krow1/Screens/auth_screen.dart';
import 'package:krow1/Screens/fav_job_screen.dart';
import 'package:provider/provider.dart';

import '../Screens/chats_screen.dart';
import '../Providers/User.dart';
import '../Screens/Jobs_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/profile_screen.dart';

class DrawerForm extends StatefulWidget {
  @override
  _DrawerFormState createState() => _DrawerFormState();
}

class _DrawerFormState extends State<DrawerForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find A  Job'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(JobsScreen.routeName);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Jobs',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(FavJobScreen.routeName);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Favorite Jobs',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    ProfileScreen.routName,
                    arguments: {'isFind': true});
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    ChatsScreen.routeName,
                    arguments: true);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Chats',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Home Screen',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () async {
                await Provider.of<Users>(context, listen: false).signOut();
                Navigator.of(context).pushReplacementNamed(AuthScreen.routName);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(
                          'https://i.pinimg.com/originals/6d/00/b2/6d00b2a3b7dd96642ca14a158a53655e.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                width: double.infinity - 10,
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
