import 'package:fitnessbuddy/component/noActivity.dart';
import 'package:fitnessbuddy/component/showHistroyComp.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:pagination/pagination.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';

import 'package:fitnessbuddy/helpers/dbhelp.dart';

class HistoryActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryActivtiyState();
  }
}

class HistoryActivtiyState extends State<HistoryActivity> {
  

  double totalPages = 0;
  //determines the total pages

  double perPage = 10;
  //shows 5 results per page

  bool dontShow=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MicrosomesDB().getActivtyPage(1).then((page) {
      print(page);
    });
   MicrosomesDB().getTotalActicities().then((total) {
      print("total $total");
      setState(() {
        totalPages = total / perPage;
        totalPages = totalPages.roundToDouble();
      });
      
      if(totalPages.round().toString()=="0"){
        print("no page available");
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: MicrosomesDB().getTotalActicities(),
      builder: (context, snapshot) {
        print(snapshot.data);

        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: totalPages.round().toString()!="0" ? DotPaginationSwiper.builder(
                  itemCount: totalPages.round(),
                  itemBuilder: (context, i) {
                    
                    return Container(
                       child: FutureBuilder(
                        future: MicrosomesDB().getActivtyPage(i),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            //all activitys are performed

                            return snapshot.data.length >= 1
                                ? Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          var dateTime = DateTime.parse(snapshot
                                              .data[index]['createdAt']);
                                          var nowTime = DateTime.now();
                                          var diffi =
                                              nowTime.difference(dateTime);

                                          return ShowHistoryComp(
                                              data: snapshot.data[index]);
                                        }),
                                  )
                                : Text("No activity logged");
                          } else {
                            return Text("loading");
                          }
                        },
                      ),
                    );
                  }):Container(
                    child: NoActivities(),
                  ));
        } else {
          return Container();
        }
      },
    );
  }
}
