import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Providers/Fav.dart';
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
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context, listen: false).getCurrentUserData().then(
            (value) => Provider.of<Jobs>(context, listen: false)
                .fetchAndSetJobs()
                .then(
                  (value) => Provider.of<Chats>(context, listen: false)
                      .fetchAndSetChats()
                      .then(
                        (value) => Provider.of<Fav>(context, listen: false)
                            .fetchUidFavStatus()
                            .then(
                              (value) =>
                                  Provider.of<Users>(context, listen: false)
                                      .getAllUserData()
                                      .then(
                                (value) {
                                  setState(
                                    () {
                                      _isLoading = false;
                                    },
                                  );
                                },
                              ),
                            ),
                      ),
                ),
          );
    } catch (err) {
      print(err);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Krow'),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Krow'),
            ),
            body: SingleChildScrollView(
              child: Slidable(
                key: const Key('id'),
                child: SlideableHome(),
                delegate: new SlidableDrawerDelegate(),
                leftActions: [
                  IconSlideAction(
                    caption: 'Find A Job',
                    color: Colors.green,
                    icon: Icons.control_point_rounded,
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(JobsScreen.routeName);
                    },
                  )
                ],
                rightActions: [
                  IconSlideAction(
                    caption: 'Post A Job',
                    color: Colors.purple,
                    icon: Icons.control_point_rounded,
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(PostJobScreen.routeName);
                    },
                  )
                ],
              ),
            ),
          );
  }
}
