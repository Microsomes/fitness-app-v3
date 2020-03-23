//page that can view the fitness article

import 'package:flutter/material.dart';
import 'package:convert/convert.dart';

import 'package:fitnessbuddy/modals/FitnessHoTo.dart';


class ReadArticle extends StatefulWidget{


  FitnessHowTo currentFitness;

  ReadArticle({this.currentFitness});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadArtcielState();
  }


}

class ReadArtcielState extends State<ReadArticle>{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.currentFitness.fitnessContent[0].getToken());
    print(widget.currentFitness.fitnessContent[0].getTokenValue());
  
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(widget.currentFitness.title),),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            for(var i=0;i<widget.currentFitness.fitnessContent.length;i++)
            Container(
              margin: EdgeInsets.only(
                top: 10
              ),
               child: widget.currentFitness.fitnessContent[i].renderNow(),
            )
          ],
        ),
      )
    );
  }

}