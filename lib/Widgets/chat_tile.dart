import 'package:flutter/material.dart';
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
    Provider.of<User>(context).uid == widget.chat.uid1
        ? Provider.of<User>(context).getIdUser(widget.chat.uid2)
        : Provider.of<User>(context).getIdUser(widget.chat.uid1);
    Users otherUser = Provider.of<User>(context).userWithId;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.lightBlue,
      ),
      child: Row(
        children: [
          Image.network(otherUser.imageUrl),
          Text(
            otherUser.username,
          )
        ],
      ),
    );
  }
}
