import 'dart:convert';
import 'package:http/http.dart';

class WorldTime {
  String location ; //location name for the UI
  String time ; // the time in that location
  String flag ;  // url(location) to an asset flag icon
  String url ; //location url for the api end point

  //make named constructor
  WorldTime( { this.location , this.flag,this.url });

  //future<void> returns await
   Future<void> getTime() async {
    //make the request and wait for the data
    Response response =  await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    String  dateTime = data['datetime'];
    //print(dateTime);
    DateTime  now = DateTime.parse(dateTime);

    //set the time property
    time = now.toString();
  }

}