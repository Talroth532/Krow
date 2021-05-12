import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../models/chat.dart';
import '../models/user.dart';
import '../Providers/Contacts.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller;
  bool _isloading = false;
  bool _isInit = true;
  String _enterdMessage = '';
  Key textFieldKey;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      // final routeArgs = ModalRoute.of(context).settings.arguments as Chat;
      // var chatId = routeArgs.id;
      Provider.of<Chats>(context, listen: false)
          .fetchMessages('wiw0RIkJiL9tz5dUPSTE')
          .then(
        (value) {
          setState(
            () {
              _isloading = false;
            },
          );
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Chat;
    var chatId = routeArgs.id;
    final uid = Provider.of<Users>(context).uid;
    Function _sendMessage = Provider.of<Chats>(context).sendMessage;
    User otherUser = routeArgs.uid1 == uid
        ? Provider.of<Contacts>(context).getContact(routeArgs.uid2)
        : Provider.of<Contacts>(context).getContact(routeArgs.uid1);
    var messages = Provider.of<Chats>(context).messages;
    messages.sort((a, b) => a.date.compareTo(b.date));
    return _isloading
        ? Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.network(
                    otherUser.imageUrl,
                    width: 20,
                    height: 20,
                  ),
                  Text(otherUser.username)
                ],
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.network(
                    otherUser.imageUrl,
                    width: 20,
                    height: 20,
                  ),
                  Text(otherUser.username)
                ],
              ),
            ),
            body: messages == null
                ? Text('This is the begining of your chat')
                : Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (ctx, index) {
                              return messages[index].posterId == uid
                                  ? Dismissible(
                                      key: Key(index.toString()),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.all(15),
                                        child: Text(messages[index].text),
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
                                      ),
                                      onDismissed: (dir) async {
                                        await Provider.of<Chats>(context,
                                                listen: false)
                                            .removeMessage(
                                                chatId, messages[index].id);
                                        setState(() {
                                          messages.removeAt(index);
                                        });
                                      },
                                    )
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(15),
                                      margin: EdgeInsets.all(15),
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
                                  decoration: InputDecoration(
                                      labelText: 'Write a message...'),
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
                                      // _controller.clear();
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
