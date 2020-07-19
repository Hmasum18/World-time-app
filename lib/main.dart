

import 'package:flutter/material.dart';
import 'package:world_time_app/pages/choose_location.dart';
import 'package:world_time_app/pages/home.dart';
import 'package:world_time_app/pages/loading.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context)=>Loading(),
    '/home': (context) => Home(), //a function which parameter is context and returns a Widget
    '/choose_location': (context) => ChooseLocation(),
  },
));
