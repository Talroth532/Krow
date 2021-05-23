import 'package:flutter/material.dart';
import 'package:krow1/models/message.dart';
import 'package:provider/provider.dart';
import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../models/chat.dart';
import '../models/user.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = new TextEditingController();
  String _enterdMessage = '';
  Key textFieldKey;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Chat;
    var chatId = routeArgs.id;
    final uid = Provider.of<Users>(context).uid;
    Function _sendMessage = Provider.of<Chats>(context).sendMessage;
    routeArgs.uid1 == uid
        ? Provider.of<Users>(context).getIdUser(routeArgs.uid2)
        : Provider.of<Users>(context).getIdUser(routeArgs.uid1);
    User otherUser = Provider.of<Users>(context).idUser;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              child: Image.network(
                otherUser.imageUrl,
                width: 40,
                height: 40,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            Text(otherUser.username)
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: Provider.of<Chats>(context).fetchMessages(chatId),
                  builder: (ctx, chatSnapshot) {
                    if (chatSnapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                    List<Message> messages = chatSnapshot.data;
                    print(messages);
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (ctx, index) {
                        return messages[index].posterId == uid
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.startToEnd,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            10,
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.all(15),
                                    child: Text(
                                      messages[index].text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  onDismissed: (dir) async {
                                    await Provider.of<Chats>(context,
                                            listen: false)
                                        .removeMessage(
                                            chatId, messages[index].id);
                                  },
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      10,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.all(15),
                                  child: Text(
                                    messages[index].text,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                                ),
                              );
                      },
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: textFieldKey,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      autocorrect: true,
                      controller: _controller,
                      enableSuggestions: true,
                      decoration:
                          InputDecoration(labelText: 'Write a message...'),
                      onChanged: (value) {
                        setState(() {
                          _enterdMessage = value;
                        });
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _enterdMessage.trim().isEmpty
                      ? null
                      : () {
                          _sendMessage(chatId, uid, _enterdMessage);
                          _controller.clear();
                        },
                ),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
