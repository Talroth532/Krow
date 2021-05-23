import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../Screens/chats_screen.dart';
import '../models/user.dart';
import '../models/job.dart';

class JobScreen extends StatefulWidget {
  static const routeName = '/JobScreen';

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    String curUseUid = Provider.of<Users>(context).uid;
    final routeArgs = ModalRoute.of(context).settings.arguments as Job;
    final posterUid = routeArgs.posterId;
    Provider.of<Users>(context).getIdUser(posterUid);
    User otherUser = Provider.of<Users>(context).idUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs.title),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Image.network(
              routeArgs.imageUrl,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              child: Card(
                child: ListView(
                  children: [
                    Container(
                      child: Text(
                        'Description :\n' + routeArgs.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Text(
                        'Payment per hour :\n' + routeArgs.payment + '\$',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Text(
                        'Poster :\n' + otherUser.username,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Text(
                        'Phone :\n' + otherUser.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 65,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: curUseUid == posterUid
                                ? null
                                : () async {
                                    int index = Provider.of<Chats>(context,
                                            listen: false)
                                        .chats
                                        .indexWhere((element) {
                                      return (element.uid1 ==
                                                  routeArgs.posterId ||
                                              element.uid2 ==
                                                  routeArgs.posterId) &&
                                          (element.uid1 == curUseUid ||
                                              element.uid2 == curUseUid);
                                    });
                                    if (index == -1) {
                                      await Provider.of<Chats>(context,
                                              listen: false)
                                          .createNewChat(
                                              curUseUid, routeArgs.posterId);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ChatsScreen.routeName,
                                              arguments: true);
                                    } else {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ChatsScreen.routeName,
                                              arguments: true);
                                    }
                                  },
                            child: Container(
                              child: Text(
                                'Contact Poster',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                color: Colors.lightBlue,
                elevation: 0,
              ),
              color: Colors.lightBlue,
              width: double.infinity,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
