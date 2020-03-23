import 'package:flutter/material.dart';
import 'package:contentful/contentful.dart';

import 'package:fitnessbuddy/modals/FitnessHoTo.dart';

import 'package:fitnessbuddy/pages/ReadFitness.dart';

class NewsContainer extends StatelessWidget {
  List<FitnessHowTo> allArticles = new List<FitnessHowTo>();

  double intendedHeight;

  NewsContainer({this.allArticles, this.intendedHeight}) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                for (var i = 0; i < allArticles.length; i++)
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("open article");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadArticle(
                                        currentFitness: allArticles[i],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: intendedHeight,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Center(
                                    child: Text(
                                  allArticles[i].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [],
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                               image: DecorationImage(
                        image: NetworkImage(allArticles[i].generateImageLink()),
                        fit: BoxFit.cover
                      )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 110,
                          child: Container(
                            child: Center(child: Text(allArticles[i].hoursAgo()+" hours ago",
                            style: TextStyle(
                              color: Color.fromRGBO(222, 222, 222, 1)
                            )
                            ,),),
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          )),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
