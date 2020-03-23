import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sql.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';

import 'package:fitnessbuddy/modals/ColorSchemes.dart';

import 'package:fitnessbuddy/pages/startTime.dart';

import 'package:fitnessbuddy/modals/Timers.dart';

import 'package:fitnessbuddy/component/addColorScheme.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fitnessbuddy/helpers/dbhelp.dart';

class EditColorScheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditColorSchemeState();
  }
}

class EditColorSchemeState extends State<EditColorScheme> {
  List<ColorSchemeMicro> allColorSchemes;
 

  EditColorSchemeState() {
    allColorSchemes = new List<ColorSchemeMicro>();

    //add the default color scheme
    allColorSchemes.add(new ColorSchemeMicro(
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
        playButtonIcon: Colors.black));

    //add the default color scheme
    allColorSchemes.add(new ColorSchemeMicro(
        startBg: Color.fromRGBO(236, 100, 75, 1), //functional
        restBg: Colors.red,
        playBg: Colors.green,
        appBarText: Colors.white,
        appBarText_rest: Colors.white,
        appBarText_work: Colors.white,
        statusTextCol: Colors.white,
        statusTextCol_rest: Colors.white,
        statusTextCol_work: Colors.white,
        playButton: Colors.white,
        playButtonIcon: Colors.black));

    allColorSchemes.add(new ColorSchemeMicro(
        startBg: Color.fromRGBO(169, 109, 173, 1), //functional
        restBg: Colors.red,
        playBg: Color.fromRGBO(169, 109, 173, 1),
        appBarText: Colors.white,
        appBarText_rest: Colors.white,
        appBarText_work: Colors.white,
        statusTextCol: Colors.white,
        statusTextCol_rest: Colors.white,
        statusTextCol_work: Colors.white,
        playButton: Colors.white,
        playButtonIcon: Colors.black));

    allColorSchemes.add(new ColorSchemeMicro(
        startBg: Color.fromRGBO(241, 231, 254, 1), //functional
        restBg: Colors.red,
        playBg: Color.fromRGBO(241, 231, 254, 1),
        appBarText: Colors.black,
        appBarText_rest: Colors.black,
        appBarText_work: Colors.black,
        statusTextCol: Colors.black,
        statusTextCol_rest: Colors.black,
        statusTextCol_work: Colors.black,
        playButton: Colors.white,
        playButtonIcon: Colors.black));

    //rgb(0, 177, 106)

    allColorSchemes.add(new ColorSchemeMicro(
        startBg: Color.fromRGBO(0, 177, 106, 1), //functional
        restBg: Colors.red,
        playBg: Color.fromRGBO(0, 177, 106, 1),
        appBarText: Colors.white,
        appBarText_rest: Colors.white,
        appBarText_work: Colors.white,
        statusTextCol: Colors.white,
        statusTextCol_rest: Colors.white,
        statusTextCol_work: Colors.white,
        playButton: Colors.white,
        playButtonIcon: Colors.black));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isShowingPrev = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Color Scheme"),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: (){
            //     setState(() {
            //       isShowingPrev= !isShowingPrev;
            //     });
            //   },
            // )
          ],
        ),
        body: isShowingPrev == true
            ? DotPaginationSwiper.builder(
                itemCount: allColorSchemes.length,
                itemBuilder: (context, i) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      PlayTime(
                        curTim: Timers(
                            playCol: "blue",
                            totalWorkout: "2",
                            totalWorkTime: "3",
                            totalRestTime: "3",
                            label: "PREVIEW-COL"),
                        activeOne: allColorSchemes[i],
                        sessionID: 0,
                      ),
                      Positioned(
                        bottom: 30,
                        child: MaterialButton(
                          height: 40,
                          minWidth: 120,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Pick Color Scheme",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                         MicrosomesDB().setColorScheme(i).then((iid) {
                              print("insert id $iid");
                              Fluttertoast.showToast(
                                  msg: "Color Scheme saved",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.lightBlue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                })
            : addColorScheme());
  }
}
