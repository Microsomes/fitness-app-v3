import 'package:http/http.dart' as http;



class Contentful{

  String accessToken;
  String spaceID;
  String environment;
  

  Contentful({this.accessToken,this.spaceID, this.environment});

  Future getAllContent(String contentType) async {

    var data= await http.get("https://cdn.contentful.com/spaces/$spaceID/environments/$environment/entries/?access_token=$accessToken&content_type=$contentType");
    return data;
  }


}