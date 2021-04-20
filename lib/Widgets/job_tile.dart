import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:krow1/Providers/Fav.dart';
import 'package:krow1/Providers/User.dart';

import 'package:krow1/models/job.dart';
import 'package:provider/provider.dart';

class JobTile extends StatefulWidget {
  final Job job;
  bool isFav;

  JobTile({
    @required this.job,
    @required this.isFav,
  });

  @override
  _JobTileState createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<User>(context).uid;
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
                icon: widget.isFav
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
                    widget.isFav = !widget.isFav;
                    changeFav(uid, widget.job.id, widget.isFav);
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
