import 'dart:math';
import 'package:flutter/material.dart';

class RandomCol{


  Map<String,Color> allColors;

  List<String> colorKeys;

    final _random = new Random();



  RandomCol(){
    allColors= new Map<String,Color>();
    colorKeys= new List<String>();

    colorKeys.add("white");
    colorKeys.add("red");
    colorKeys.add("orange");
    colorKeys.add("yellow");
    colorKeys.add("green");
    colorKeys.add("blue");
    colorKeys.add("indigo");
    colorKeys.add("violet");
    colorKeys.add("black");
    colorKeys.add("grey");

    allColors['white']=Colors.white;
    allColors['red']=Colors.red;
    allColors['orange']=Colors.orange;
    allColors['yellow']=Colors.yellow;
    allColors['green']=Colors.green;
    allColors['blue']=Colors.blue;
    allColors['indigo']=Colors.indigo;
    allColors['violet']=Colors.purple;
    allColors['black']=Colors.black;
    allColors['grey']=Colors.grey;

  }

  String getRandomColor(){
         int next(int min, int max) => min + _random.nextInt(max - min);
    return colorKeys[next(0, colorKeys.length)];
  }

  Color getColorFromKey(String key){
    return  allColors[key];
  }

}