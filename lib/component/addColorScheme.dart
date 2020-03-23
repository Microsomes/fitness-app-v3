import 'package:fitnessbuddy/modals/Timers.dart';
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:fitnessbuddy/pages/startTime.dart';
import 'package:fitnessbuddy/modals/ColorSchemes.dart';

import 'ColorPickerMicro.dart';

class addColorScheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addColorSchemeState();
  }
}

class addColorSchemeState extends State<addColorScheme> {
  bool isRe = true;

  List<Widget> previewScreens = new List<Widget>();

  addColorSchemeState() {
    previewScreens.add(PlayTime(
      curTim: Timers(
          playCol: "blue",
          totalWorkout: "2",
          totalWorkTime: "3",
          totalRestTime: "3",
          label: "PREVIEW-COL"),
      activeOne: currentOne,
      sessionID: 0,
    ));
  }

  ColorSchemeMicro currentOne = new ColorSchemeMicro(
      startBg: Colors.white,
      restBg: Colors.white,
      playBg: Colors.white,
      appBarText: Colors.black,
      appBarText_rest: Colors.black,
      appBarText_work: Colors.black,
      statusTextCol: Colors.black,
      statusTextCol_rest: Colors.black,
      statusTextCol_work: Colors.black,
      playButton: Colors.white,
      playButtonIcon: Colors.black);
  //the color scheme that we will be saving

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add your own Color Scheme",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Tap anywhere to edit",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              print("show color editor");

              showDialog(
                  context: context,
                  builder: (BuildContext cx) {
                    return AlertDialog(
                      title: Text("Color Scheme Editor"),
                      actions: <Widget>[],
                      content: Column(
                        children: <Widget>[
                          Text("Start- Background Color"),
                          ColorPickerMicro(
                            onChange: (cur) {
                              //color selected
                              print("op");
                              setState(() {
                                currentOne.startBg = Colors.red;
                              
                                

                                
                              });
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
            child: isRe == true ? previewScreens[0] : Container(),
          ),
        )
      ],
    );
  }
}
