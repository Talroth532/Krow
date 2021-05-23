import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Jobs.dart';
import 'job_screen.dart';
import '../models/job.dart';
import '../Widgets/job_tile.dart';
import '../Widgets/drawer_form.dart';

class JobsScreen extends StatefulWidget {
  static const routeName = '/JobsScreen';
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Job> jobs = Provider.of<Jobs>(context).jobs;
    return Scaffold(
      appBar: AppBar(
        title: Text('Find A Job'),
      ),
      endDrawer: Drawer(
        child: DrawerForm(),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return FlatButton(
            child: JobTile(
              job: jobs[index],
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(JobScreen.routeName, arguments: jobs[index]);
            },
          );
        },
        itemCount: jobs.length,
      ),
    );
  }
}
