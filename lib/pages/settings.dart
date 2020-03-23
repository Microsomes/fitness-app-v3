import 'package:fitnessbuddy/pages/Disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fitnessbuddy/pages/ColorSchemeP.dart';


class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  Future deleteAllActivies() async {
    Database db = await openDatabase("microsomes6.db");
    var id = await db.rawQuery("DELETE FROM activityhistory");
    var id2 = await db.rawQuery("DELETE FROM defaultColorScheme");

     
    return id;
  }

  Future deleteTimers() async {
    Database db= await openDatabase("microsomes6.db");
    var id= await db.rawQuery("DELETE FROM timers");
    return id;
  }

  bool experiemental = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "settings",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "On the settings page you may reset all the activites and read the TOS.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(222, 222, 222, 1),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Delete Activity",
                    style: TextStyle(
                        color: Color.fromRGBO(212, 212, 212, 1), fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.lightBlue,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        deleteAllActivies().then((updateid) {
                          print("deleted $updateid");
                        });
                           Fluttertoast.showToast(
                            msg: "Deleted all activities!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Delete Timers",
                    style: TextStyle(
                        color: Color.fromRGBO(212, 212, 212, 1), fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.lightBlue,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        deleteTimers().then((updateid) {
                          print("deleted $updateid");
                        });
                           Fluttertoast.showToast(
                            msg: "Deleted all timers!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
              Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Color Schemes",
                    style: TextStyle(
                        color: Color.fromRGBO(212, 212, 212, 1), fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.lightBlue,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditColorScheme()) );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            experiemental == true
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Please save this file somewhere safe. You may need this file if you ever change your phone.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(222, 222, 222, 1)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Export Data    ",
                              style: TextStyle(
                                  color: Color.fromRGBO(212, 212, 212, 1),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.lightBlue,
                                child: Text(
                                  "Export",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ))
                : Container(),
                Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    "TOS                  ",
                    style: TextStyle(
                        color: Color.fromRGBO(212, 212, 212, 1), fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.lightBlue,
                      child: Text(
                        "TOS/Disclaimer",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>TermesOfService()));
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
        
            SizedBox(
              height: 10,
            ),
            Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Fitness Timer is a interval based workout program that helps you track your workouts.",textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(222, 222, 222, 1)
                      ),
                      ),
                    ),
                  ),
              
            
          ],
        ));
  }
}
