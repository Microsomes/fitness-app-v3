import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';



class ShowVideoM extends StatefulWidget{
  final String videoID;
  ShowVideoM(this.videoID);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowVideoMState();
  }

  
}

class ShowVideoMState extends State<ShowVideoM>{


  VideoPlayerController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var vidID= widget.videoID;

      //init the video
      controller= new VideoPlayerController.network("https://tayyabprojects.info/egvid/$vidID")
      ..initialize().then((p){
        //ensures the first frame is loaded
        setState(() {
          
        });
      });



  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
       children: <Widget>[

        controller.value.initialized ? Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: InkWell(
            onTap: (){
              if(controller.value.isPlaying){
                //if video is playing pause
                controller.pause();
              }else{
                controller.play();
              }
            },
                    child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ):Container()
      ],
    );
  }

}