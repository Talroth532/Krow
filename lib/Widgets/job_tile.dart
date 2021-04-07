import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class JobTile extends StatefulWidget {
  String jobTitle;
  String imageURL;
  String description;
  String payment;
  bool isFav;

  JobTile({
    @required this.jobTitle,
    @required this.imageURL,
    @required this.description,
    @required this.payment,
    @required this.isFav,
  });

  @override
  _JobTileState createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Image.network(widget.imageURL),
                width: 70,
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: 20,
              ),
              Text(widget.jobTitle),
              SizedBox(
                width: 200,
              ),
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
                  });
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          Container(
            child: Text(widget.description),
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
