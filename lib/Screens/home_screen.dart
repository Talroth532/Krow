import 'package:flutter/material.dart';
import 'package:krow1/Providers/Chats.dart';
import 'package:krow1/Providers/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:krow1/Screens/post_job_screen.dart';
import '../Providers/Jobs.dart';
import 'Jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Jobs>(context).fetchAndSetJobs();
    Provider.of<Chats>(context).fetchAndSetChats();
    Provider.of<User>(context).getCurrentUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Krow'),
        ),
        body:
            //Row(
            //   children: [
            //     FlatButton(
            //       child: Container(
            //         child: Stack(
            //           children: [
            //             Image.network(
            //               'https://icon-library.com/images/social-media-icon-collage/social-media-icon-collage-12.jpg',
            //               height: double.infinity,
            //               fit: BoxFit.fill,
            //             ),
            //             Container(
            //               child: Text(
            //                 'Find\n\nA\n\nJob',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 80,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ),
            //           ],
            //           alignment: Alignment.center,
            //         ),
            //         width: (MediaQuery.of(context).size.width / 2) - 5,
            //         height: double.infinity,
            //         padding: EdgeInsets.all(0),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context).pushNamed(JobsScreen.routeName);
            //       },
            //       padding: EdgeInsets.all(0),
            //     ),
            //     Container(
            //       width: 10,
            //       height: double.infinity,
            //       color: Colors.blue,
            //     ),
            //     FlatButton(
            //       onPressed: () {
            //         Navigator.of(context).pushNamed(PostJobScreen.routeName);
            //       },
            //       child: Container(
            //         child: Stack(
            //           children: [
            //             Image.network(
            //               '',
            //               height: double.infinity,
            //               fit: BoxFit.fill,
            //             ),
            //             Container(
            //               child: Text(
            //                 'Post\n\nA\n\nJob',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 80,
            //                   fontWeight: FontWeight.w600,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ),
            //           ],
            //           alignment: Alignment.center,
            //         ),
            //         width: (MediaQuery.of(context).size.width / 2) - 5,
            //         height: double.infinity,
            //         padding: EdgeInsets.all(0),
            //       ),
            //     ),
            //   ],
            // ),
            Slidable(
          key: const Key('id'),
          child: Text('Swipe To go'),
          delegate: new SlidableDrawerDelegate(),
          leftActions: [
            IconSlideAction(
              caption: 'Find A Job',
              color: Colors.lightBlue,
              icon: Icons.control_point_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(JobsScreen.routeName);
              },
            )
          ],
          rightActions: [
            IconSlideAction(
              caption: 'Post A Job',
              color: Colors.lightBlue,
              icon: Icons.control_point_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(PostJobScreen.routeName);
              },
            )
          ],
        ));
  }
}
