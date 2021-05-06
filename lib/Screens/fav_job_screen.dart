import 'package:flutter/material.dart';
import 'package:krow1/Screens/job_Screen.dart';
import 'package:krow1/Widgets/drawer_form.dart';
import 'package:krow1/Widgets/job_tile.dart';
import 'package:krow1/models/job.dart';
import 'package:provider/provider.dart';

import '../Providers/Fav.dart';
import '../Providers/Jobs.dart';

class FavJobScreen extends StatelessWidget {
  static const String routeName = '/FavJobScreen';

  @override
  Widget build(BuildContext context) {
    final userJobs = Provider.of<Fav>(context).userJobs;
    final allJobs = Provider.of<Jobs>(context).jobs;
    List<Job> favJobs = [];
    for (int i = 0; i < allJobs.length; i++) {
      for (int k = 0; k < userJobs.length; k++) {
        if (allJobs[i].id == userJobs[k].jobId) {
          favJobs.add(allJobs[i]);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Jobs'),
      ),
      endDrawer: Drawer(
        child: DrawerForm(),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return FlatButton(
            child: JobTile(job: favJobs[index]),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(JobScreen.routeName, arguments: favJobs[index]);
            },
          );
        },
        itemCount: favJobs.length,
      ),
    );
  }
}
