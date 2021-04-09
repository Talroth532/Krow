import 'package:flutter/material.dart';
import 'package:krow1/Widgets/chat_tile.dart';
import 'package:provider/provider.dart';

import '../models/chat.dart';
import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../Widgets/drawer_form.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Chat> allChats = Provider.of<Chats>(context).chats;
    String uid = Provider.of<User>(context).uid;

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
                  return ChatTile(
                    chat: chats[index],
                  );
                },
                itemCount: chats.length,
              )
            : Text('you have no chats'));
  }
}
