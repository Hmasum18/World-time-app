import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time_app/utils/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setUpWorldTimeApi() async{
    WorldTime worldTimeInstance = WorldTime(location: 'Dhaka',flag: 'dhaka.png',  url: 'Asia/Dhaka');
    await worldTimeInstance.getTime(); //wait until getTime function get function get the time from the worldtime api
    print(worldTimeInstance.time);
    setState(() {
      time = worldTimeInstance.time;
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTimeApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(time),
      ),
    );
  }
}
