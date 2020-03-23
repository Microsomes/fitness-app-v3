import 'package:flutter/material.dart';
import 'package:fitnessbuddy/helpers/dbhelp.dart';

class ShowHistoryComp extends StatefulWidget {
  dynamic data;

  var diffiferencetime;

  bool isShowingExtra;

  String activityDuration;
  //determines the activity duration



  ShowHistoryComp({this.data}) {
    var dateTime = DateTime.parse(data['createdAt']);
    var nowTime = DateTime.now();
    var diffi = nowTime.difference(dateTime);
    diffiferencetime = diffi;
    isShowingExtra = false;

    activityDuration= data['duration'];
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowHistoryComp_State();
  }
}

class ShowHistoryComp_State extends State<ShowHistoryComp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
      MicrosomesDB().getTimerByName(widget.data['intervalName'].toString()).then((timerdata){
     });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        ListTile(
          leading: FutureBuilder(
            future:  MicrosomesDB().getTimerByName(widget.data['intervalName'].toString()),
            builder: (context,snapshot){

              if(snapshot.connectionState==ConnectionState.done){

              
              print(snapshot.data[0]['iconLink']);
              return  CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data[0]['iconLink']),
               backgroundColor: Colors.lightBlue,
            );
              }else{
                return Text("something went wrong");
              }
            },
                      
          ),
          title: Text(
         widget.data['id'].toString()+":"+   widget.data['intervalName'],
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text(widget.diffiferencetime.inMinutes.toString() +
                  " minutes ago"),
              SizedBox(
                height: 5,
              ),
             ],
          ),
          trailing: widget.isShowingExtra == false
              ? IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      widget.isShowingExtra = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    setState(() {
                      widget.isShowingExtra = false;
                    });
                  },
                ),
        ),
        widget.isShowingExtra == true
            ? Container(
                height: 200,
                color: Color.fromRGBO(232, 232, 232, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.activityDuration+" seconds activity duration")
                      ],
                    )
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}

// class ShowHistoryComp {
//   dynamic data;

//   var diffiferencetime;

//   ShowHistoryComp({this.data}) {
//     var dateTime = DateTime.parse(data['createdAt']);
//     var nowTime = DateTime.now();
//     var diffi = nowTime.difference(dateTime);
//     diffiferencetime = diffi;
//   }

//   Widget renderComp() {
//     return ListTile(
//       title: Text(
//         data['intervalName'],
//         style: TextStyle(
//             fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
