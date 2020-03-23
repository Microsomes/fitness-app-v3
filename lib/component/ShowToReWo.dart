//shows the total work time rest 

import 'package:flutter/material.dart';

class ShowTotalRestWork{

  String totalWorkout;
  String workTime;
  String restTime;

  ShowTotalRestWork({this.totalWorkout, this.workTime, this.restTime});


  Widget renderNow(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
          child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightGreen
            ),
            child: Column(
            children: <Widget>[
              Text("Total Workout",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text("$totalWorkout minutes",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)
            ],
          ),
          ),
           Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.yellow
            ),
            child: Column(
            children: <Widget>[
              Text("Work-Time",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
              Text("$workTime seconds",textAlign: TextAlign.center,)
            ],
          ),
          ), Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red
            ),
            child: Column(
            children: <Widget>[
              Text("Rest-Time",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text("$restTime seconds",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)
            ],
          ),
          )
        ],
      ),
    );
  }

}