import 'package:flutter/material.dart';

class TimerInput extends StatefulWidget {
  Function onchange;

  String label;

  int current;

  TimerInput({this.onchange, this.current, this.label}){
    onchange(0);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimerInputState();
  }
}

class _TimerInputState extends State<TimerInput> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                child: Text("+",style: TextStyle(fontSize: 20),),
                onPressed: () {
                  setState(() {
                    widget.current += 5;
                  });
                  widget.onchange(widget.current);
                },
              ),
              Text(widget.current.toString(),style: TextStyle(fontSize: 20),),
              MaterialButton(
                child: Text("-",style: TextStyle(fontSize: 20),),
                onPressed: () {
                  if(widget.current<=0){

                  }else{
                  setState(() {
                    widget.current -= 1;
                  });
                  widget.onchange(widget.current);
                  }
                },
              )
            ],
          )),
          SizedBox(height: 5,),
          Text("( "+widget.label+" )",style: TextStyle(color: Colors.white),)
        ],
      )
    );
  }
}
