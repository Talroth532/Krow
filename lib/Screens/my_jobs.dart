import 'package:flutter/material.dart';
import 'package:krow1/Providers/Jobs.dart';
import 'package:krow1/Providers/User.dart';
import 'package:provider/provider.dart';

import '../Widgets/post_drawer.dart';
import '../Widgets/my_job_tile.dart';

class MyJobScreen extends StatefulWidget {
  static const String routeName = '/MyJobScreen';

  @override
  _MyJobScreenState createState() => _MyJobScreenState();
}

class _MyJobScreenState extends State<MyJobScreen> {
  @override
  Widget build(BuildContext context) {
    var allJobs = Provider.of<Jobs>(context).jobs;
    var uid = Provider.of<User>(context).uid;
    var myJobs = allJobs.where((element) {
      return element.posterId == uid;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posted Jobs'),
      ),
      drawer: PostDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MyJobTile(job: myJobs[index]);
        },
        itemCount: myJobs.length,
      ),
    );
  }
}
