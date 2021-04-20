import 'package:flutter/material.dart';
import 'package:krow1/Providers/User.dart';
import 'package:krow1/models/userJob.dart';
import 'package:provider/provider.dart';

import '../Providers/Fav.dart';
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
    List<UserJob> userJobs = Provider.of<Fav>(context).userJobs;
    return Scaffold(
        appBar: AppBar(
          title: Text('Find A Job'),
        ),
        endDrawer: Drawer(
          child: DrawerForm(),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            Provider.of<Fav>(context).fetchUidFavStatus();
            return FlatButton(
              child: JobTile(
                  job: jobs[index],
                  isFav: userJobs.firstWhere((element) {
                    return element.jobId == jobs[index].id;
                  }).isFav),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(JobScreen.routeName, arguments: jobs[index]);
              },
            );
          },
          itemCount: jobs.length,
        ));
  }
}
