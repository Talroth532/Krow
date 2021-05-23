import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/auth_screen.dart';
import '../Screens/fav_job_screen.dart';
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                          'https://static.vecteezy.com/system/resources/previews/001/189/063/non_2x/star-rounded-png.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Favorite Jobs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                          'https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                          'https://webstockreview.net/images/conversation-clipart-group-chat-6.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Chats',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/OOjs_UI_icon_logOut-ltr.svg/1200px-OOjs_UI_icon_logOut-ltr.svg.png'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
