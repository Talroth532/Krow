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
                child: Image.network(''),
                borderRadius: BorderRadius.circular(15),
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
