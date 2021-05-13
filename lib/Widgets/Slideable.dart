import 'package:flutter/material.dart';

class SlideableHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Image.network(
                      'https://st.depositphotos.com/1272497/1275/v/600/depositphotos_12754007-stock-illustration-blue-background-and-frame.jpg',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      child: Text(
                        'Find A Job',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  alignment: Alignment.center,
                ),
                height: (MediaQuery.of(context).size.height / 2) - 45,
                width: double.infinity,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
              ),
              Container(
                color: Colors.lightBlue,
                width: double.infinity,
                height: 10,
              ),
              Container(
                child: Stack(
                  children: [
                    Image.network(
                      'https://st.depositphotos.com/1272497/1275/v/600/depositphotos_12754007-stock-illustration-blue-background-and-frame.jpg',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      child: Text(
                        'Post A Job',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  alignment: Alignment.center,
                ),
                height: (MediaQuery.of(context).size.height / 2) - 45,
                width: double.infinity,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.lightBlue,
          ),
          child: Row(
            children: [
              Icon(
                Icons.arrow_left_outlined,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.arrow_right_outlined,
                color: Colors.white,
                size: 30,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        )
      ],
      alignment: Alignment.center,
    );
  }
}
