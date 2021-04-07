import 'package:flutter/material.dart';
import 'package:krow1/Providers/Chats.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat.dart';
import '../Widgets/drawer_form.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Chat> allChats = Provider.of<Chats>(context).chats;
    Future GetUid(String uid) async {
      var user = await FirebaseAuth.instance.currentUser();
      uid = user.uid;
    }

    String uid;
    GetUid(uid);

    List<Chat> chats = allChats.where(
      (element) => (element.uid1 == uid || element.uid2 == uid),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('chat'),
        ),
        endDrawer: Drawer(
          child: DrawerForm(),
        ),
        body: chats != null
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return null;
                },
                itemCount: chats.length,
              )
            : Text('you have no chats'));
  }
}
