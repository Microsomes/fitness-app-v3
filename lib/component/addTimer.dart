import 'package:fitnessbuddy/helpers/dbhelp.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';

import './../modals/Timers.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sqflite/sqflite.dart';

import 'package:fitnessbuddy/component/timerAddMinus.dart';

import 'package:fitnessbuddy/modals/randomWords.dart';

import 'package:fitnessbuddy/modals/randomColor.dart';

import 'package:fitnessbuddy/helpers/Contentful.dart';

import 'dart:convert';

class AddTimer extends StatefulWidget {
  Function oncancel;

  Contentful cf;

  AddTimer({@required this.oncancel}) {
    cf = Contentful(
        accessToken: "fc6khhr513WfMCatMhTuLhVJhsdIINqRMEZO-Wd_-X4",
        spaceID: "cexmr9o8dphe",
        environment: "master");
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTimerstate();
  }
}

class AddTimerstate extends State<AddTimer> {
  List<Timers> allTimers = new List<Timers>();

  TextEditingController totalDurationController = new TextEditingController();

  TextEditingController workDurationController = new TextEditingController();

  TextEditingController restDurationController = new TextEditingController();

  TextEditingController labelController = new TextEditingController();

  RandomWords rw;
  RandomCol rc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalDurationController.text = "60";
    workDurationController.text = "30";
    restDurationController.text = "30";
    rw = new RandomWords();
    rc = new RandomCol();
  }

  String circleAvatar= "http://178.62.3.11/fitnessicon/004-cardio.png";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: new Container(
          height: 800,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      leading: InkWell(
                        onTap: () async {
                          print("....");

                          //load icons

                          widget.cf.getAllContent("fitnessIcons").then((data) {
                            Map<String, dynamic> fitnessIcons =
                                jsonDecode(data.body);

                            int totalFitness = fitnessIcons['items'].length;

                            var label= fitnessIcons['items'][0]['fields']['label'];

                            var iconImageURL= fitnessIcons['items'][0]['fields']['iconImage']['content'][0]['content'][1]['data']['uri'];

                            var iconI =  (int index){
                              return fitnessIcons['items'][index]['fields']['iconImage']['content'][0]['content'][1]['data']['uri'];
                            };

                            


                            showDialog(
                                context: context,
                                builder: (BuildContext bx) {
                                  return AlertDialog(
                                    title: Text("Pick icon"),
                                    content: SingleChildScrollView(
                                      child: Wrap(
                                        children: <Widget>[
                                          for (var i = 0; i < totalFitness; i++)
                                          
                                            Container(
                                              margin: EdgeInsets.all(1),
                                              child: InkWell(
                                                onTap: () {
                                                  print("pick icon $i");
                                                  setState(() {
                                                    circleAvatar= iconI(i);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      iconI(i)),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              circleAvatar),
                        ),
                      ) /*IconButton(
                        onPressed: () {
                          labelController.text = rw.getRandomWord();
                        },
                        icon: Icon(
                          Icons.short_text,
                          color: Colors.white,
                        ),
                      )*/
                      ,
                      title: Text(
                        "Label for timer",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: TextField(
                          controller: labelController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "type something or leave empty",
                              hintStyle: TextStyle(color: Colors.white)))),
                  ListTile(
                      title: Text(
                        "Total Duration",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: TimerInput(
                        onchange: (int tI) {
                          print("something changed $tI");
                          totalDurationController.text = tI.toString();
                        },
                        current: 0,
                        label: "Minutes",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      title: Text(
                        "Work time",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: TimerInput(
                        onchange: (int tI) {
                          workDurationController.text = tI.toString();
                        },
                        current: 0,
                        label: "Seconds",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      title: Text(
                        "Rest time",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: TimerInput(
                        current: 0,
                        onchange: (int tI) {
                          restDurationController.text = tI.toString();
                        },
                        label: "Seconds",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Add Fitness Timer",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      //TODO check if inputs are even used
                      if (totalDurationController.text == "0") {
                        print("n/a");
                        Fluttertoast.showToast(
                            msg: "Total Duration cannot be zero",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }
                      if (workDurationController.text == "0") {
                        print("n/a");
                        Fluttertoast.showToast(
                            msg: "Work time cannot be 0 seconds",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }
                      if (restDurationController.text == "0") {
                        print("n/a");
                        Fluttertoast.showToast(
                            msg:
                                "Rest time cannot be 0 seconds. Your not super human. ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }

                      allTimers.add(new Timers(
                          totalRestTime:
                              restDurationController.text, //amount of rest time
                          totalWorkout: totalDurationController
                              .text, // amount of the total workout
                          totalWorkTime: workDurationController
                              .text // amount of the time working
                          ));

                      //need to add this to the database
                      Timers cur = new Timers(
                          totalRestTime:
                              restDurationController.text, //amount of rest time
                          totalWorkout: totalDurationController
                              .text, // amount of the total workout
                          totalWorkTime: workDurationController
                              .text // amount of the time working
                          );

                          if (labelController.text.length <= 0) {
                          labelController.text = rw.getRandomWord();
                        }

                        //adds timer
                        MicrosomesDB().addTimer(totalDurationController.text, workDurationController.text, restDurationController.text, labelController.text, rc.getRandomColor(),circleAvatar);

                          widget.oncancel();


                      
                   
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
