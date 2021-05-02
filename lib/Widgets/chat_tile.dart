import 'package:flutter/material.dart';
import 'package:krow1/Providers/Contacts.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import 'package:krow1/models/chat.dart';
import 'package:krow1/models/user.dart';

class ChatTile extends StatefulWidget {
  final Chat chat;

  ChatTile({
    @required this.chat,
  });

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    User otherUser;
    String uid = Provider.of<Users>(context).uid;
    List<User> contacts = Provider.of<Contacts>(context).contacts;
    for (int i = 0; i < contacts.length; i++) {
      if (widget.chat.uid1 == uid) {
        if (contacts[i].id == widget.chat.uid2) {
          otherUser = contacts[i];
          break;
        }
      } else if (widget.chat.uid2 == uid) {
        if (contacts[i].id == widget.chat.uid1) {
          otherUser = contacts[i];
          break;
        }
      }
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.lightBlue,
      ),
      child: Row(
        children: [
          Image.network(
            otherUser.imageUrl,
            height: 50,
            width: 50,
          ),
          Text(
            otherUser.username,
          )
        ],
      ),
    );
  }
}
