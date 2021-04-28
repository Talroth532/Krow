import 'package:flutter/material.dart';
import 'package:krow1/Providers/Chats.dart';
import 'package:krow1/Providers/User.dart';
import 'package:krow1/models/user.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';

class JobScreen extends StatefulWidget {
  static const routeName = '/JobScreen';
  // final Job job;

  // JobScreen(this.job );

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    String curUseUid = Provider.of<User>(context).uid;
    final routeArgs = ModalRoute.of(context).settings.arguments as Job;
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
                child: Column(
                  children: [
                    Container(
                        child: Text('Description :\t' + routeArgs.description),
                        padding: EdgeInsets.all(10)),
                    Container(
                        child: Text('Payment :\t' + routeArgs.payment),
                        padding: EdgeInsets.all(10)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 100),
                        RaisedButton(
                          onPressed: () {
                            int index = Provider.of<Chats>(context)
                                .chats
                                .indexWhere((element) {
                              return (element.uid1 == routeArgs.posterId ||
                                      element.uid1 == routeArgs.posterId) &&
                                  (element.uid1 == curUseUid ||
                                      element.uid2 == curUseUid);
                            });
                            if (index != -1) {
                            } else {}
                          },
                          child: Container(),
                        )
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
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
