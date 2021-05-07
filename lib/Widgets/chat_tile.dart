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
    otherUser = widget.chat.uid1 == uid
        ? Provider.of<Contacts>(context).getContact(widget.chat.uid2)
        : Provider.of<Contacts>(context).getContact(widget.chat.uid1);

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
