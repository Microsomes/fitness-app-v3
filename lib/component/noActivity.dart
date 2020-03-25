import 'package:flutter/material.dart';

//component to show the user no activies have been logged

class NoActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          "No activities have been logged. Try creating a workout timer and working out!!!. Please wait up to 10 workouts before the history page shows anything. This is due to our machine learning algorithm.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(222, 222, 222, 1),
            fontSize: 20
          ),
        ))
      ],
    );
  }
}
