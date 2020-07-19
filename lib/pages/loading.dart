import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getData() async {
    //make the request and wait for the data
     Response response =  await get('http://worldtimeapi.org/api/timezone/Asia/Dhaka');
     Map data = jsonDecode(response.body);
     String  dateTime = data['datetime'];
   //print(dateTime);
     DateTime  now = DateTime.parse(dateTime);
     print(now);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('loading screen'),
    );
  }
}
