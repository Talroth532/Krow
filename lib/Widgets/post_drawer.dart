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
                          'https://icons-for-free.com/iconfiles/png/512/new+plus+icon-1320196808672578110.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Post A Job',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          'https://pics.freeicons.io/uploads/icons/png/19360626041548336247-512.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'My Jobs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          'https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          'https://webstockreview.net/images/conversation-clipart-group-chat-6.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Chats',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          'https://cdn4.iconfinder.com/data/icons/pictype-free-vector-icons/16/home-512.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Home Screen',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/OOjs_UI_icon_logOut-ltr.svg/1200px-OOjs_UI_icon_logOut-ltr.svg.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
