import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/chat_screen.dart';
import '../Widgets/chat_tile.dart';
import '../Widgets/post_drawer.dart';
import '../models/chat.dart';
import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../Widgets/drawer_form.dart';

class ChatsScreen extends StatefulWidget {
  static String routeName = '/ChatsScreen';

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Chat> allChats = Provider.of<Chats>(context).chats;
    String uid = Provider.of<Users>(context).uid;
    bool _isFind = ModalRoute.of(context).settings.arguments as bool;

    List<Chat> chats = allChats
        .where(
          (element) => (element.uid1 == uid || element.uid2 == uid),
        )
        .toList();

    return chats.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text('Chats'),
            ),
            drawer: _isFind
                ? null
                : Drawer(
                    child: PostDrawer(),
                  ),
            endDrawer: _isFind
                ? Drawer(
                    child: DrawerForm(),
                  )
                : null,
            body: Center(
              child: Text(
                'You have no chats',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Chats'),
            ),
            drawer: _isFind
                ? null
                : Drawer(
                    child: PostDrawer(),
                  ),
            endDrawer: _isFind
                ? Drawer(
                    child: DrawerForm(),
                  )
                : null,
            body: chats != null
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          child: FlatButton(
                            child: ChatTile(
                              chat: chats[index],
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                ChatScreen.routeName,
                                arguments: chats[index],
                              );
                            },
                          ),
                          onDismissed: (DismissDirection dir) async {
                            await Provider.of<Chats>(context, listen: false)
                                .removeChat(chats[index].id);
                            setState(() {
                              chats.removeAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                            ),
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      );
                    },
                    itemCount: chats.length,
                  )
                : Text('you have no chats'),
          );
  }
}
