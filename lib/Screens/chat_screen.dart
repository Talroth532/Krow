import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../models/chat.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<Users>(context).uid;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Chat>;
    var chatId = routeArgs['Chat'].id;
    Provider.of<Chats>(context).fetchMessages(chatId);
    final messages = Provider.of<Chats>(context).messages;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Image.network(''), Text('')],
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (ctx, index) {
          return messages[index].posterId == uid
              ? Container(
                  child: Text(messages[index].text),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                )
              : Container(
                  child: Text(messages[index].text),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                );
        },
      ),
    );
  }
}
