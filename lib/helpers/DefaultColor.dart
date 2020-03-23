import 'package:fitnessbuddy/modals/ColorSchemes.dart';
import 'package:flutter/material.dart';

class DefaultColor {
  List<ColorSchemeMicro> allColorSchemes;

  DefaultColor() {
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

  ColorSchemeMicro getDefultScheme(int index) {
    return allColorSchemes[index];
  }
}
