import 'package:fitnessbuddy/modals/FitnessContent.dart';
class FitnessHowTo{

  String headerImage;
  String title;
  String content;
  String createdAT;
  

  List<FitnessContent> fitnessContent;
  //all the contents will be placed in here



  String generateImageLink(){
    return headerImage;
  }

  String minutesAgo(){
    DateTime now= DateTime.now();
    DateTime parse= DateTime.parse(this.createdAT);
    var toRet=  now.difference(parse).inMinutes;

    return  toRet.toString();
  }

   String hoursAgo(){
    DateTime now= DateTime.now();
    DateTime parse= DateTime.parse(this.createdAT);
    var toRet=  now.difference(parse).inHours;

    return  toRet.toString();
  }


  FitnessHowTo({this.title, this.content, this.createdAT,this.headerImage,this.fitnessContent});

}