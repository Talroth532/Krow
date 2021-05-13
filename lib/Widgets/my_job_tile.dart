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
                child: ClipRRect(
                  child: Image.network(widget.job.imageUrl),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 70,
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 10,
              ),
              Text(
                widget.job.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          Container(
            child: Text(
              widget.job.description,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
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
