import 'dart:convert';

import 'package:fitnessbuddy/modals/FitnessHoTo.dart';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:fitnessbuddy/component/MVideo.dart';

class FitnessContent {
  dynamic value;

  Widget whatToRender;

  FitnessContent({this.value});

  //returns token
  dynamic getToken() {
    return this.value['value'].split("@")[1].split("(")[0];
  }

  dynamic getTokenValue() {
    return this.value['value'].split("@")[1].split("(")[1].split(")")[0];
  }

  Widget renderNow() {
    switch (getToken().toString()) {
      case "header":
        //render header
        return Container(
          alignment: Alignment.center,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              getTokenValue().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
          ),
        );
        break;

      case "img":
        return Container(
          child: Image.network(getTokenValue().toString()),
        );
        break;

        case "p1":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 15
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;
        case "p2":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 20
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;
        case "p3":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 25
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;
        case "p4":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 30
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;
        case "p5":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 35
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;
        case "p6":
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10),
            child: Text(getTokenValue().toString(),style: TextStyle(
              fontSize: 40
            ),
            textAlign: TextAlign.center,),
          ),
        );
        break;

        case "video":
          print(getTokenValue()+"-");
        return Container(
          child: ShowVideoM(getTokenValue().toString())
        );
        break;
        

      default:
        return Container();
        break;
    }
  }
}
