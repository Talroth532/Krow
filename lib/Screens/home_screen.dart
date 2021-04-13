import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Providers/Chats.dart';
import '../Providers/User.dart';
import '../Screens/post_job_screen.dart';
import '../Providers/Jobs.dart';
import '../Screens/Jobs_screen.dart';
import '../Widgets/Slideable.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Jobs>(context).fetchAndSetJobs().then((value) {
      Provider.of<Chats>(context).fetchAndSetChats().then((value) {
        Provider.of<Chats>(context).fetchAndSetChats().then((value) {
          Provider.of<User>(context).getCurrentUserData();
        });
      });
    });

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
          child: SlideableHome(),
          delegate: new SlidableDrawerDelegate(),
          leftActions: [
            IconSlideAction(
              caption: 'Find A Job',
              color: Colors.green,
              icon: Icons.control_point_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(JobsScreen.routeName);
              },
            )
          ],
          rightActions: [
            IconSlideAction(
              caption: 'Post A Job',
              color: Colors.purple,
              icon: Icons.control_point_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(PostJobScreen.routeName);
              },
            )
          ],
        ));
  }
}
