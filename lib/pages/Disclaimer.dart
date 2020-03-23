import 'package:flutter/material.dart';



class TermesOfService extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal bits"),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Fitness buddy strongly recommends that you consult with your physician before beginning any exercise program. You should be in good physical condition and be able to participate in the exercise. Fitness buddy is not a licensed medical care provider and represents that it has no expertise in diagnosing, examining, or treating medical conditions of any kind, or in determining the effect of any specific exercise on a medical condition.",
                style: TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
                ),
            )
          ],
        ),
      ),
    );
  }

}