import 'package:flutter/material.dart';
import 'package:krow1/Widgets/post_drawer.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../Widgets/drawer_form.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    User curUse = Provider.of<Users>(context).curUse;
    var _args = ModalRoute.of(context).settings.arguments as Map<String, bool>;
    bool isFind = _args['isFind'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: isFind
          ? null
          : Drawer(
              child: PostDrawer(),
            ),
      endDrawer: isFind
          ? Drawer(
              child: DrawerForm(),
            )
          : null,
      body: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                child: Container(
                  child: Image.network(curUse.imageUrl),
                  height: 100,
                  width: 100,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              Text('Username:\t' + curUse.username),
            ],
          ),
          Text('Email:\t' + curUse.email),
          Text('Phone:\t' + curUse.phone),
          RaisedButton(
            onPressed: null,
            child: Container(
              child: Text('Edit Profile'),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
