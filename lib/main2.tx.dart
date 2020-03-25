import 'dart:math';
import 'package:fitnessbuddy/pages/ReadFitness.dart';
import 'package:fitnessbuddy/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'component/addTimer.dart';
import 'package:fitnessbuddy/modals/ColorSchemes.dart';

import 'helpers/DefaultColor.dart';

import 'package:sqflite/sqflite.dart';

import 'package:fitnessbuddy/modals/Timers.dart';

import 'package:fitnessbuddy/pages/startTime.dart';

import 'package:fitnessbuddy/component/newContainter.dart';

import 'helpers/Contentful.dart';

import 'modals/FitnessHoTo.dart';

import 'dart:convert';

import 'modals/FitnessContent.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'modals/randomColor.dart';

import 'component/ShowToReWo.dart';

import 'package:fitnessbuddy/pages/HistoryActivity.dart';

import 'package:fitnessbuddy/pages/Featurescomingsoon.dart';

import 'helpers/dbhelp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Timers> allTimers = new List<Timers>();

  List<Timers> allPreTimers = new List<Timers>();
  //details a list of pre-build timers

  List<FitnessHowTo> allFitnessHowTos = new List<FitnessHowTo>();

  List<FitnessHowTo> AllFitnessHowTos_Quick = new List<FitnessHowTo>();

  Contentful cb = Contentful(
      accessToken: "fc6khhr513WfMCatMhTuLhVJhsdIINqRMEZO-Wd_-X4",
      spaceID: "cexmr9o8dphe",
      environment: "master");

  bool isShow = true;

  int currentIndex = 0;

  List<Widget> allPages = List<Widget>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allPages.add(FirstPage(
      cb: cb,
      allFitnessHowTos: allFitnessHowTos,
      allTimers: allTimers,
      allPreTimers: allPreTimers,
      rc: new RandomCol(),
      AllFitnessHowTos_Quick: AllFitnessHowTos_Quick,
      changeBottomNavi: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    ));
    allPages.add(HistoryActivity());
    allPages.add(new AddTimer(
      oncancel: () {
        setState(() {
          currentIndex = 0;
        });
      },
    ));
    allPages.add(Comingsoon());

    //grab all the pretimers
    cb.getAllContent("fitnessPresets").then((presents) {
      Map<String, dynamic> fp = jsonDecode(presents.body);
      var totalPresets = fp['total'];
      //determines the total amount of presets

      fp['items'].forEach((item) {
        var label = item['fields']['label'];
        var duration = item['fields']['duration'];
        var worktime = item['fields']['workTime'];
        var resttime = item['fields']['restTime'];
        var helpcontent = item['fields']['helperContent'];
        var ishelp = item['fields']['isHelp'];

        var background = item['fields']['backgroundUrl']['content'][0]
            ['content'][1]['data']['uri'];

        print(background);

        print(label);

        Timers curT = new Timers(
          label: label,
          playCol: "n/a",
          totalWorkout: duration,
          totalWorkTime: worktime,
          totalRestTime: resttime,
        );
        curT.version = "2";
        //set the version to 2

        List<FitnessContent> fitnessCont = new List<FitnessContent>();
        //all fitness content will be stored here

        helpcontent['content'].forEach((content) {
          var val = content['content'][0];
          fitnessCont.add(FitnessContent(value: val));
        });

        curT.addBackgrondImage(background);
        //adds background image
        curT.addHelpContent(fitnessCont);

        curT.isHelpContent = true;

        setState(() {
          allPreTimers.add(curT);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(title: "Home", iconData: Icons.home),
              TabData(title: "History", iconData: Icons.history),
              TabData(title: "Add Timer", iconData: Icons.add),
              TabData(title: "Calendar", iconData: Icons.calendar_today),
            ],
            onTabChangedListener: (pos) {
              setState(() {
                currentIndex = pos;
              });
            }),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Fitness Buddy",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isShow = false;
                });
                setState(() {
                  isShow = true;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => FancyDialog(
                          title: "Add Fitness Interval",
                          descreption:
                              "You will create a rest interval and a work interval. At both intervals a sound will be sounded to indicate a work period or rest period.",
                        ));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                //opens the settings page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: isShow == true ? allPages[currentIndex] : Container());
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage(
      {Key key,
      @required this.cb,
      @required this.allFitnessHowTos,
      @required this.allTimers,
      @required this.allPreTimers,
      @required this.rc,
      @required this.AllFitnessHowTos_Quick,
      @required this.changeBottomNavi})
      : super(key: key);

  final Contentful cb;
  final List<FitnessHowTo> allFitnessHowTos;
  final List<Timers> allTimers;
  final List<Timers> allPreTimers;
  final List<FitnessHowTo> AllFitnessHowTos_Quick;
  //details a list of pre-build timers
  final Function changeBottomNavi;

  final RandomCol rc;

  Future getDefaultColorScheme() async {
    Database db = await openDatabase("microsomes6.db", version: 1);
    List<Map> listAll = await db
        .rawQuery("SELECT * FROM defaultColorScheme ORDER BY id DESC LIMIT 1 ");
    return listAll;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Fitness How-tos",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              )),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    height: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "See all",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print("see fitness how tos");
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext cbx) {
                            return Container(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount: allFitnessHowTos.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print("open article $index");
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadArticle(
                                                          currentFitness:
                                                              allFitnessHowTos[
                                                                  index],
                                                        )));
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.lightBlue,
                                              child: Text(
                                                allFitnessHowTos[index]
                                                    .title[index],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            subtitle: Text(
                                              allFitnessHowTos[index]
                                                      .hoursAgo()
                                                      .toString() +
                                                  " hours ago",
                                            ),
                                            title: Text(
                                                allFitnessHowTos[index].title),
                                          ),
                                        );
                                      }),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.lightBlue,
                                    icon: Icon(Icons.close),
                                  ),
                                )
                              ],
                            ));
                          });
                    },
                    color: Colors.lightBlue,
                  )
                ],
              )),

          SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: cb.getAllContent("fitnessarticle"),
              builder: (context, snapshot) {
                allFitnessHowTos.removeRange(0, allFitnessHowTos.length);

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> da = jsonDecode(snapshot.data.body);

                  da['items'].forEach((content) {
                    var createdAt = content['sys']['createdAt'];
                    //date stamp for when the article was created
                    var title = content['fields']['title'];
                    //article title
                    var headerImageid = content['fields']['imageLink'];
                    var contentsOfArticle = "n/a";

                    List<FitnessContent> fc = new List<FitnessContent>();

                    content['fields']['content']['content'].forEach((con) {
                      var dataNode1 = con['content'][0];
                      fc.add(new FitnessContent(value: dataNode1));
                    });

                    allFitnessHowTos.add(new FitnessHowTo(
                        content: contentsOfArticle,
                        createdAT: createdAt,
                        title: title,
                        headerImage: headerImageid,
                        fitnessContent: fc));
                  });

                  ///
                  ///
                  ///
                  ///

                  return NewsContainer(
                    allArticles: allFitnessHowTos,
                    intendedHeight: 150,
                  );
                }

                return Text("Sorry no internet. Could not load articles");
              },
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Quick-Workout moves",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              )),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    height: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "See all",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext cbx) {
                            return Container(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount: AllFitnessHowTos_Quick.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print("open article $index");
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadArticle(
                                                          currentFitness:
                                                              AllFitnessHowTos_Quick[
                                                                  index],
                                                        )));
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.lightBlue,
                                              child: Text(
                                                AllFitnessHowTos_Quick[index]
                                                    .title[index],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            subtitle: Text(
                                              AllFitnessHowTos_Quick[index]
                                                      .hoursAgo()
                                                      .toString() +
                                                  " hours ago",
                                            ),
                                            title: Text(
                                                AllFitnessHowTos_Quick[index]
                                                    .title),
                                          ),
                                        );
                                      }),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.lightBlue,
                                    icon: Icon(Icons.close),
                                  ),
                                )
                              ],
                            ));
                          });
                    },
                    color: Colors.lightBlue,
                  )
                ],
              )),
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: cb.getAllContent("quickworkoutmove"),
              builder: (context, snapshot) {
                AllFitnessHowTos_Quick.removeRange(
                    0, AllFitnessHowTos_Quick.length);
                //empty the whole quickout array

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> da = jsonDecode(snapshot.data.body);

                  da['items'].forEach((content) {
                    var createdAt = content['sys']['createdAt'];
                    //date stamp for when the article was created
                    var title = content['fields']['title'];
                    //article title
                    var headerImageid = content['fields']['imageLink'];
                    var contentsOfArticle = "n/a";

                    List<FitnessContent> fc = new List<FitnessContent>();

                    content['fields']['content']['content'].forEach((con) {
                      var dataNode1 = con['content'][0];
                      fc.add(new FitnessContent(value: dataNode1));
                    });

                    AllFitnessHowTos_Quick.add(new FitnessHowTo(
                        content: contentsOfArticle,
                        createdAT: createdAt,
                        title: title,
                        headerImage: headerImageid,
                        fitnessContent: fc));
                  });

                  ///
                  ///
                  ///
                  ///

                  return NewsContainer(
                    allArticles: AllFitnessHowTos_Quick,
                    intendedHeight: 100,
                  );
                }

                return Text("Sorry no internet. Could not load articles");
              },
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Fitness Interval Timers",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Please click on the intervals to start workout",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      )
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(top: 4),
              color: Color.fromRGBO(232, 232, 232, 1),
              child: FutureBuilder(
                future: new MicrosomesDB().getAllTimers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    allTimers.removeRange(0, allTimers.length);
                    snapshot.data.forEach((val) {
                      allTimers.add(new Timers(
                          playCol: val['playcolor'],
                          totalWorkout: val['totalWorkout'],
                          totalWorkTime: val['totalWorkTime'],
                          totalRestTime: val['totalRestTime'],
                          label: val['label'].toString()));
                    });
                  }
                  return allTimers.length >= 1
                      ? ListView.builder(
                          itemCount: allTimers.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () async {
                                MicrosomesDB()
                                    .addHistoryActivity(allTimers[i].label)
                                    .then((obi) {
                                  print("id insert $obi");

                                  DefaultColor df = new DefaultColor();

                                  getDefaultColorScheme().then((schemeID) {
                                    print(schemeID);
                                    if (schemeID.length <= 0) {
                                      print("nothing selected default 0");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PlayTime(
                                                  curTim: allTimers[i],
                                                  sessionID: obi,
                                                  activeOne:
                                                      df.getDefultScheme(0))));
                                    } else {
                                      var scid = schemeID[0]['schemeid'];
                                      print("scheme id $scid");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PlayTime(
                                                  curTim: allTimers[i],
                                                  sessionID: obi,
                                                  activeOne: df
                                                      .getDefultScheme(scid))));
                                    }
                                  });
                                });
                              },
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: rc
                                        .getColorFromKey(allTimers[i].playCol),
                                    child: Icon(Icons.play_arrow),
                                  ),
                                  title: Text(
                                    allTimers[i].label,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: ShowTotalRestWork(
                                          totalWorkout:
                                              allTimers[i].totalWorkout,
                                          workTime: allTimers[i].totalWorkTime,
                                          restTime: allTimers[i].totalRestTime)
                                      .renderNow()),
                            );
                          })
                      : Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "No workout timers created",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Create Timer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    changeBottomNavi(2);
                                  },
                                  color: Colors.lightBlue,
                                )
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Pre-Built timers",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Click on any of these to start an epic session!",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: Wrap(
                      children: <Widget>[
                        for (var i = 0; i < allPreTimers.length; i++)
                          InkWell(
                            onTap: () {
                              MicrosomesDB()
                                  .addHistoryActivity(allPreTimers[i].label)
                                  .then((obi) {
                                print("id insert $obi");

                                DefaultColor df = new DefaultColor();

                                getDefaultColorScheme().then((schemeID) {
                                  if (schemeID.length <= 0) {
                                    print("nothing selected default 0");

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlayTime(
                                                curTim: allPreTimers[i],
                                                sessionID: obi,
                                                activeOne:
                                                    df.getDefultScheme(0))));
                                  } else {
                                    var scid = schemeID[0]['schemeid'];
                                    print("scheme id $scid");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlayTime(
                                                curTim: allPreTimers[i],
                                                sessionID: obi,
                                                activeOne:
                                                    df.getDefultScheme(scid))));
                                  }
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 5),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.all(20),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          allPreTimers[i].backgroundImage)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    allPreTimers[i].label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          )

          //shows text how too
        ],
      )),
    );
  }
}
