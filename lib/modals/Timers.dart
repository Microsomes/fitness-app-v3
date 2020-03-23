import 'package:flutter/cupertino.dart';

import 'package:fitnessbuddy/modals/FitnessContent.dart';
import 'package:flutter/material.dart';

class Timers{
  String label;
  String totalWorkout;
  String totalWorkTime;
  String totalRestTime;
  String playCol;

  String version;
  //depends which version this is


  List<FitnessContent> helpContent;

  bool isHelpContent;
  //determines if help content is available

  String backgroundImage;






  Timers({this.label, @required this.totalRestTime, @required this.totalWorkTime, @required this.totalWorkout,@required this.playCol}){
    version="1";
    //default is version 1
    helpContent=new List<FitnessContent>();
    //init the list

    backgroundImage="http://178.62.3.11/fitnessicon/002-chest.png";
    //default image

    isHelpContent=false;
    //default not available
  }

  void addHelpContent(List<FitnessContent> allCon){
    this.helpContent= allCon;
    this.isHelpContent=true;
  }


  void addBackgrondImage(String img){
    this.backgroundImage=img;
  }

  void changeVersion(String ver){
    this.version=ver;
  }

  Map<String,dynamic> toMap(){
    var map= <String, dynamic>{'totalWorkout':totalWorkout, 'totalWorkTime':totalWorkTime, 'totalRestTime':totalRestTime};
    return map;
  }


  Timers.fromMap(Map<String,dynamic> map){
    totalWorkout= map['totalWorkout'];
    totalWorkTime= map['totalWorkTime'];
    totalRestTime= map['totalRestTime'];
  }


}