import 'package:flutter/material.dart';
import 'package:krow1/Screens/Jobs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krow1/Screens/profile_screen.dart';

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
      body: Column(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, JobsScreen.routeName);
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
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ProfileScreen.routName);
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
          FlatButton(
            onPressed: () {
              setState(() {
                FirebaseAuth.instance.signOut();
              });
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
          )
        ],
      ),
    );
  }
}
