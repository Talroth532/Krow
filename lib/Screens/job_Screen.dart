import 'package:flutter/material.dart';

import '../models/job.dart';

class JobScreen extends StatefulWidget {
  static const routeName = '/Jobscreen';
  // final Job job;

  // JobScreen(this.job );

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
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
