import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String TAG = 'Home';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    //recieves the map that we passed form Loading as argumenets
    data = ModalRoute.of(context).settings.arguments;
    print('$TAG : $data');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body:  Column(
        children: <Widget>[
          Text('Home screen'),
          FlatButton.icon(
            color: Colors.pinkAccent,
            onPressed: (){
              Navigator.pushNamed(context, '/choose_location');
            },
            icon: Icon(Icons.edit_location),
              label: Text("choose location"),
          )
        ],
      ),
    );
  }
}
