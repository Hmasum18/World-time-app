import 'package:flutter/material.dart';
import 'package:world_time_app/screens/choose_location.dart';
import 'package:world_time_app/screens/home.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  //init timezone from database
  tz.initializeTimeZones();

  return runApp(MaterialApp(
    routes: {
      '/': (context) { return Home();}, //a function which parameter is context and returns a Widget
      '/choose_location': (context) => ChooseLocation(), // this a short form to return it.
    },
  ));
}
