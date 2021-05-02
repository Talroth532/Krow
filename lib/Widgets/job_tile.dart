import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../Providers/Fav.dart';
import '../Providers/User.dart';
import '../models/job.dart';

class JobTile extends StatefulWidget {
  final Job job;

  JobTile({
    @required this.job,
  });

  @override
  _JobTileState createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<Users>(context).uid;
    Function changeFav = Provider.of<Fav>(context).updateStatus;
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
              IconButton(
                icon: Provider.of<Fav>(context).checkIfExist(widget.job)
                    ? Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                      ),
                onPressed: () {
                  setState(() {
                    changeFav(uid, widget.job.id);
                  });
                },
              )
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
