import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'dart:math';

class IntervalCircle extends CustomPainter {
  double currentProgress;

  double currentProgress2;
  double currentProgress3;

  Color circle1;
  Color circlr2;
  Color circle3;

  IntervalCircle(
      {this.currentProgress,
      this.circle1,
      this.circlr2,
      this.circle3,
      this.currentProgress2,
      this.currentProgress3});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint


    Paint linep= Paint()
    ..color=Colors.red
    ..strokeCap= StrokeCap.round

    ..strokeWidth=40;

//    canvas.drawRRect(
//      RRect.fromRectAndRadius(Rect.fromLTWH(size.width/2+-15, 10, 30, 30), Radius.circular(20)),
//      linep,
//    );
//    canvas.drawRRect(
//      RRect.fromRectAndRadius(Rect.fromLTWH(size.width/2+-15, size.height*0.9+1, 30, 30), Radius.circular(20)),
//      linep,
//    );
//    canvas.drawRRect(
//      RRect.fromRectAndRadius(Rect.fromLTWH(6, size.height/2, 15, 15), Radius.circular(20)),
//      linep,
//    );
//
//    canvas.drawRRect(
//      RRect.fromRectAndRadius(Rect.fromLTWH(size.width*0.94, size.height/2, 15, 15), Radius.circular(20)),
//      linep,
//    );

 
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 1
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint completeArc_c1 = Paint()
      ..strokeWidth = 25
      ..color = circle1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Paint completeArc_c2 = Paint()
      ..strokeWidth = 25
      ..color = circlr2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Paint completeArc_c3 = Paint()
      ..strokeWidth = 25
      ..color = circle3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 40;

    //

    // draw text

    // ui.TextStyle ts = ui.TextStyle(color: Colors.black, fontSize: 30);

    // ui.ParagraphStyle ps = ui.ParagraphStyle(textDirection: TextDirection.ltr);

    // ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ps)
    //   ..pushStyle(ts)
    //   ..addText("Hello world");

    // var constraints = ui.ParagraphConstraints(width: 300);
    // var paragraph = paragraphBuilder.build();
    // paragraph.layout(constraints);
    // Offset textOffset = Offset(50, 50);
    // canvas.drawParagraph(paragraph, textOffset);

    //draw text

    canvas.drawCircle(center, radius, outerCircle);

    canvas.drawCircle(center, radius / 1.5, outerCircle);

    canvas.drawCircle(
        center, radius / 3, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress / 100);
    double angle2 = 2 * pi * (currentProgress2 / 100);
    double angle3 = 2 * pi * (currentProgress3 / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc_c1);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 1.5),
        -pi / 2, angle2, false, completeArc_c2);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 3), -pi / 2,
        angle3, false, completeArc_c3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
