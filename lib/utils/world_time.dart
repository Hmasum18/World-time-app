import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:world_time_app/pages/home.dart';

class WorldTime {
  final String TAG = 'WorldTime class';

  String location ; //location name for the UI
  String time ; // the time in that location
  String date ;
  String flag ;  // url(location) to an asset flag icon
  String url ; //location url for the api end point
  bool isDay;

  //make named constructor
  WorldTime( { this.location , this.flag,this.url });

  //future<void> returns await
   Future<void> getTime() async {
    //make the request and wait for the data
     try{
       Response response =  await get('http://worldtimeapi.org/api/timezone/$url');
       Map data = jsonDecode(response.body);
       String  dateTime = data['datetime'];
       String offset = data['utc_offset'].toString().substring(1,3);
       print('datetime : $dateTime');
       print('offset : $offset');
       //print(dateTime);
       DateTime  now = DateTime.parse(dateTime);
       now = now.add(Duration(hours: int.parse(offset)));
       isDay = now.hour>=6 && now.hour<=18 ? true : false;
       //set the time property
       time = DateFormat.jm().format(now);
       date = '${now.day}/${now.month}/${now.year}';
       print('$TAG : $date');
     }catch(e)
     {
       print('Error: $e');
       time = 'could not get time data';
     }

  }

}