import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/job.dart';

class MyJobTile extends StatefulWidget {
  final Job job;

  MyJobTile({
    @required this.job,
  });

  @override
  _MyJobTileState createState() => _MyJobTileState();
}

class _MyJobTileState extends State<MyJobTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Image.network(widget.job.imageUrl),
                width: 70,
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
              Text(widget.job.title),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          Container(
            child: Text(widget.job.description),
            padding: EdgeInsets.all(10),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      elevation: 5,
      color: Colors.lightBlue,
    );
  }
}
