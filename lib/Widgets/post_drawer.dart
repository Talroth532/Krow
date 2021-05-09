import 'package:flutter/material.dart';
import 'package:krow1/Screens/auth_screen.dart';
import 'package:krow1/Screens/chats_screen.dart';
import 'package:krow1/Screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../Screens/home_screen.dart';
import '../Screens/my_jobs.dart';
import '../Screens/post_job_screen.dart';

class PostDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(PostJobScreen.routeName);
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
                      'Post A Job',
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
                Navigator.of(context).pushNamed(MyJobScreen.routeName);
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
                      'My Jobs',
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
                    arguments: {'isFind': false});
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
                    arguments: false);
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
                Provider.of<Users>(context, listen: false).signOut();
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
