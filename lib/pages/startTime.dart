import 'dart:async';

import 'package:fitnessbuddy/component/timerAddMinus.dart';
import 'package:flutter/material.dart';
import 'package:fitnessbuddy/modals/Timers.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fitnessbuddy/helpers/Contentful.dart';

import 'dart:convert';

import 'package:flame/flame.dart';

import 'package:fitnessbuddy/painters/IntervalCircle.dart';

import 'package:fitnessbuddy/modals/ColorSchemes.dart';

class PlayTime extends StatefulWidget {
  final Timers curTim;

  ColorSchemeMicro activeOne;
  //the color scheme that will be used for this time

  Contentful cf;

  int sessionID;
  //determines which historical log to attach this workout too

  Future addDurationToSessionActivity(String duration, int id) async {
    var db = await openDatabase("microsomes6.db", version: 1);

    int updateid = await db.rawUpdate(
        "UPDATE activityhistory SET duration=? WHERE id=?", [duration, id]);

    return updateid;
  }

  PlayTime({@required this.curTim, this.sessionID, this.activeOne}) {
    cf = Contentful(
        accessToken: "fc6khhr513WfMCatMhTuLhVJhsdIINqRMEZO-Wd_-X4",
        spaceID: "cexmr9o8dphe",
        environment: "master");
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlayTimeState();
  }
}

class PlayTimeState extends State<PlayTime> {
  Timer runTIme;

  Timer totalTime;
  Timer workTime;
  Timer restTime;

  bool isStart = false;
  //determines if its started

  var totalTimeEslaped = 0;
  //determines how much time has already elasped

  var nextBreak;
  //determines when the next break is

  var nextWork;
  //determines the duration of the next worktime

  var breakEnd = 0;

  var workEnd = 0;

  int sid;

  String status = "warmup. Click play to start";

  double totalRunTimeStatus = 0;

  double totalSecondCircleRunTime = 0;

  bool isCompleted = false;
  //true if the whole workout is completed

  bool showHowFeeling = false;
  //only show this on breaks

  bool showTimer = false;

  int intervalCount = 1;
  //keeps track of which interval the user is on

  Color workCircleCol = Colors.transparent;

  Color restCircle = Colors.transparent;

  Color statusText = Colors.grey;
  //status text color

  Color backgroundColor = Colors.white;
  //main screen background color

  Color appBarTextCol = Colors.black;
  //remotes the appbar text color

  Color playButtonBG = Colors.white;
  //defines the background color of the play button

  Color playButtonIconCol = Colors.black;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    runTIme.cancel();
  }

  stopTimer() {
    runTIme.cancel();
  }

  void startTimer() {
    if (runTIme != null) {
      runTIme.cancel();
    }

    double restInteval = double.parse(widget.curTim.totalRestTime);
    double workInterval = double.parse(widget.curTim.totalWorkTime);

    double totalTime = double.parse(widget.curTim.totalWorkout);
    //determines what the total workout time is
    setState(() {
      status = "Warm up time";
      totalRunTimeStatus = 0;
    });

    nextBreak = 0;

    runTIme = Timer.periodic(Duration(seconds: 1), (Timer rs) {
      totalTimeEslaped++;

      setState(() {
        totalRunTimeStatus = (100 / (totalTime * 60)) * totalTimeEslaped;
      });

      if (totalRunTimeStatus >= 100) {
        print("over");

        showDialog(
            context: context,
            builder: (BuildContext conx) {
              return AlertDialog(
                title: Text("Congratualations"),
                content: Text("You have just completed the " +
                    widget.curTim.label +
                    " workout."),
              );
            });
        setState(() {
          isCompleted = true;
        });
        widget
            .addDurationToSessionActivity(
                totalTimeEslaped.toString(), widget.sessionID)
            .then((updateid) {
          print("updated duration $updateid");
        });
        stopTimer();
      }

      if (totalTimeEslaped >= restInteval) {
        breakEnd++;

        if (breakEnd >= restInteval) {
          workEnd++;

          //now for 60 seconds its non break time
          //work time

          if (workEnd >= workInterval) {
            print("work is over");

            setState(() {
              intervalCount++;
              totalSecondCircleRunTime = 0;
            });

            breakEnd = 0;
            workEnd = 0;
            widget
                .addDurationToSessionActivity(
                    totalTimeEslaped.toString(), widget.sessionID)
                .then((updateid) {
              print("updated duration $updateid");
            });
          } else {
            print("still working");
            setState(() {
              status = "Workout";
              restCircle = Colors.lightGreen;
              workCircleCol = Colors.lightGreen;
              totalSecondCircleRunTime = (100 / workInterval) * workEnd;
              restCircle = Colors.red;
              workCircleCol = Colors.green;
              backgroundColor = widget.activeOne.playBg;
              appBarTextCol = widget.activeOne.appBarText_work;
              statusText = widget.activeOne.statusTextCol_work;
            });
          }
        } else {
          print("still on break;");
          Flame.audio.play("beep.wav");

          setState(() {
            appBarTextCol = widget.activeOne.appBarText_rest;
            statusText = widget.activeOne.statusTextCol_rest;

            backgroundColor = widget.activeOne.restBg;
            restCircle = Colors.red;
            workCircleCol = Colors.red;
            totalSecondCircleRunTime = (100 / restInteval) * breakEnd;
            restCircle = Colors.green;
            workCircleCol = Colors.red;
          });

          setState(() {
            status = "Break";
          });
        }
      } else {
        workEnd = 0;
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //set up all the timers

    backgroundColor = widget.activeOne.startBg;
    //set the start background color
    appBarTextCol = widget.activeOne.appBarText;
    statusText = widget.activeOne.statusTextCol;
    playButtonBG = widget.activeOne.playButton;
    playButtonIconCol = widget.activeOne.playButtonIcon;

    Flame.audio.play("beep.wav");
    //play intro sound
    print("==" + widget.curTim.isHelpContent.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: isCompleted == false
            ? FloatingActionButton(
                backgroundColor: playButtonBG,
                child: isStart == false
                    ? Icon(
                        Icons.play_arrow,
                        color: playButtonIconCol,
                      )
                    : Icon(
                        Icons.pause,
                        color: playButtonIconCol,
                      ),
                onPressed: () {
                  if (isStart == false) {
                    startTimer();
                    setState(() {
                      isStart = true;
                    });
                  } else {
                    stopTimer();
                    setState(() {
                      isStart = false;
                    });
                  }
                },
              )
            : Container(),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: statusText,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          title: Text(
            widget.curTim.label +
                "(" +
                double.parse(totalTimeEslaped.toString()).toString() +
                ")",
            style: TextStyle(color: appBarTextCol),
          ),
          actions: <Widget>[],
        ),
        body: widget.curTim.isHelpContent
            ? PreferredSize(
                preferredSize: new Size(100, 100),
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: backgroundColor,
                      leading: Container(),
                      bottom: TabBar(
                        indicatorColor: Colors.lightBlue,
                        tabs: <Widget>[
                          Tab(
                              icon: Icon(
                            Icons.help,
                            color: statusText,
                          )),
                          Tab(
                              icon: Icon(
                            Icons.play_arrow,
                            color: statusText,
                          )),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Duration:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 21,
                                            child: Text(
                                              widget.curTim.totalWorkout +
                                                  " minutes",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Work-Time:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 21,
                                            child: Text(
                                              widget.curTim.totalWorkTime +
                                                  " seconds",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Rest-Time:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 21,
                                            child: Text(
                                              widget.curTim.totalRestTime +
                                                  " seconds",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1)),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                color: Colors.white,
                              ),
                              for (var i = 0;
                                  i < widget.curTim.helpContent.length;
                                  i++)
                                widget.curTim.helpContent[i].renderNow()
                            ],
                          ),
                        ),
                        PageOne(
                            isCompleted: isCompleted,
                            backgroundColor: backgroundColor,
                            totalRunTimeStatus: totalRunTimeStatus,
                            totalSecondCircleRunTime: totalSecondCircleRunTime,
                            workCircleCol: workCircleCol,
                            restCircle: restCircle,
                            status: status,
                            statusText: statusText,
                            showTimer: showTimer,
                            intervalCount: intervalCount,
                            widget: widget),
                      ],
                    ),
                  ),
                ),
              )
            : PageOne(
                isCompleted: isCompleted,
                backgroundColor: backgroundColor,
                totalRunTimeStatus: totalRunTimeStatus,
                totalSecondCircleRunTime: totalSecondCircleRunTime,
                workCircleCol: workCircleCol,
                restCircle: restCircle,
                status: status,
                statusText: statusText,
                showTimer: showTimer,
                intervalCount: intervalCount,
                widget: widget));
  }
}

class PageOne extends StatelessWidget {
  const PageOne({
    Key key,
    @required this.isCompleted,
    @required this.backgroundColor,
    @required this.totalRunTimeStatus,
    @required this.totalSecondCircleRunTime,
    @required this.workCircleCol,
    @required this.restCircle,
    @required this.status,
    @required this.statusText,
    @required this.showTimer,
    @required this.intervalCount,
    @required this.widget,
  }) : super(key: key);

  final bool isCompleted;
  final Color backgroundColor;
  final double totalRunTimeStatus;
  final double totalSecondCircleRunTime;
  final Color workCircleCol;
  final Color restCircle;
  final String status;
  final Color statusText;
  final bool showTimer;
  final int intervalCount;
  final PlayTime widget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            isCompleted == false
                ? Container(
                    color: backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 320,
                          width: MediaQuery.of(context).size.width,
                          child: CustomPaint(
                            painter: IntervalCircle(
                                currentProgress: totalRunTimeStatus,
                                currentProgress2: 100,
                                currentProgress3: totalSecondCircleRunTime,
                                circle1: Colors.green,
                                circlr2: workCircleCol,
                                circle3: restCircle),
                          ),
                        ),
                        Text(
                          "$status",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: statusText),
                        ),
                        Container(
                          height: 300,
                          color: Colors.white,
                        ),
                        showTimer == true
                            ? AlertDialog(
                                title: Text("Interval $intervalCount"),
                                content: Column(
                                  children: <Widget>[
                                    Text(
                                      "Log any reps,sets or counts you did?",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "At every rest period you will get a chance to log your reps.",
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      height: 100,
                                      child: TimerInput(
                                        current: 0,
                                        label: "",
                                        onchange: (index) {
                                          print("changed $index");
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ))
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        AlertDialog(
                          title: Text("How are you feeling?"),
                          content: Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Amazing",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Exhaused",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      color: Colors.lightBlue,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        AlertDialog(
                          title: Text("Well done"),
                          content: Container(
                            height: 150,
                            child: FutureBuilder(
                              future: widget.cf.getAllContent("fitnessQuotes"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  print("loaded fitness quotes");

                                  Map<String, dynamic> toConv =
                                      jsonDecode(snapshot.data.body);
                                  var totalResults = toConv['total'];

                                  return ListView.builder(
                                      itemCount: totalResults,
                                      itemBuilder: (context, index) {
                                        return Text(toConv['items'][index]
                                                ['fields']['quote']
                                            .toString());
                                      });
                                } else {
                                  return Text("something went wrong sorry.");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
