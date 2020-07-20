import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:world_time_app/utils/world_time.dart';

final String TAG = 'Loading';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setUpWorldTimeApi() async{
    WorldTime worldTimeInstance = WorldTime(location: 'Dhaka',flag: 'dhaka.png',  url: 'Asia/Dhaka');
    await worldTimeInstance.getTime(); //wait until getTime function get function get the time from the worldtime api
    print('$TAG : ${worldTimeInstance.time} ');
    //show the loading widget for 2 seconds
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/home',arguments: {
     'location' : worldTimeInstance.location,
     'flag' : worldTimeInstance.flag,
     'time' : worldTimeInstance.time,
      'isDay' : worldTimeInstance.isDay,
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
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
