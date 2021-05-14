import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../Providers/Fav.dart';
import '../models/job.dart';

class JobTile extends StatefulWidget {
  final Job job;
  bool _isLoading = false;

  JobTile({
    @required this.job,
  });

  @override
  _JobTileState createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  @override
  Widget build(BuildContext context) {
    Function changeFav = Provider.of<Fav>(context).updateStatus;
    bool isFav = Provider.of<Fav>(context).checkIfExist(widget.job);
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
                width: 20,
              ),
              Text(
                widget.job.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
              ),
              widget._isLoading
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: isFav
                          ? Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          : Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                            ),
                      onPressed: () async {
                        setState(() {
                          widget._isLoading = true;
                        });
                        await changeFav(widget.job.id);
                        setState(() {
                          isFav = !isFav;
                          widget._isLoading = false;
                        });
                      },
                      alignment: Alignment.topRight,
                    )
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
