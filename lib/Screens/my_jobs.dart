import 'package:flutter/material.dart';
import 'package:krow1/Providers/Jobs.dart';
import 'package:krow1/Providers/User.dart';
import 'package:provider/provider.dart';

import '../Widgets/post_drawer.dart';

class MyJobs extends StatefulWidget {
  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
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
        itemBuilder: null,
        itemCount: myJobs.length,
      ),
    );
  }
}
