import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../Widgets/drawer_form.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    Users curUse = Provider.of<User>(context).curUse;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      endDrawer: Drawer(
        child: DrawerForm(),
      ),
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
          Text('Phone:\t' + curUse.phone)
        ],
      ),
    );
  }
}
