import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class WorldTime {
  static final String TAG = "WorldTime->";

  String location; //location name for the UI
  String time; // the time in that location
  String date;

  String flag; // url(location) to an asset flag icon
  String relativePath; //location url for the api end point
  bool isDay;

  //make named constructor
  WorldTime({this.location, this.flag, this.relativePath});

  //future<void> returns await
  Future<void> fetchTime() async {
    //make the request and wait for the data
    try {
      String url = 'https://worldtimeapi.org/api/timezone/$relativePath';
      print("$TAG calling api $url");
      http.Response response = await http.get(url, headers: {
        "Accept": "application/json",
      });
      Map data = json.decode(response.body);
      print("$TAG response body: ${response.body}");

      _parseData(data);
    } catch (e) {
     // print('$TAG fetchTime(): Error: $e');
      print('$TAG fetchTime(): Error fetching data for $relativePath');

      //use timeZone api to generate time.
      _setFormattedDateTime(DateTime.now());
    }
  }

  void _parseData(Map data) {
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].toString();
    print('$TAG _parseData(): datetime : $dateTime');
    print('$TAG _parseData(): uct_offset : $offset');

    DateTime now = DateTime.parse(dateTime);

    // detect day or night
    /*if (offset[0] == '+')
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));
    else
      now = now.subtract(Duration(hours: int.parse(offset.substring(1, 3))));
    isDay = now.hour >= 6 && now.hour < 18 ? true : false;*/

    //format date and time
    _setFormattedDateTime(now);
  }

  void _setFormattedDateTime(DateTime dateTime) {
    tz.Location location = tz.getLocation(relativePath);
    dateTime = tz.TZDateTime.from(dateTime, location);
    print("$TAG _formatDateTime(): timeZone name: ${dateTime.timeZoneName}");
    print("$TAG _formatDateTime(): timeZone offset: ${dateTime.timeZoneOffset.inHours}");

    this.isDay = dateTime.hour >= 6 && dateTime.hour < 18 ? true : false;
    this.time = DateFormat.jm().format(dateTime);
    this.date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    print("$TAG _formatDateTime(): $time, $date");
  }

  @override
  String toString() {
    // TODO: implement toString
    return "WordTime{location: $location, time: $time, date: $date, flag: $flag, relativePath: $relativePath, isDay: $isDay}";
  }
}
