import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';
import '../models/chat.dart';
import '../models/user.dart';

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
    widget.chat.uid1 == uid
        ? Provider.of<Users>(context).getIdUser(widget.chat.uid2)
        : Provider.of<Users>(context).getIdUser(widget.chat.uid1);
    otherUser = Provider.of<Users>(context).idUser;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.lightBlue,
      ),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              otherUser.imageUrl,
              height: 50,
              width: 50,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          Text(
            otherUser.username,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
    );
  }
}
