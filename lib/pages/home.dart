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
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(0,110,0,0),
        child: Column(
          children: <Widget>[
            FlatButton.icon(
              color: Colors.pinkAccent,
              onPressed: (){
                Navigator.pushNamed(context, '/choose_location');
              },
              icon: Icon(Icons.edit_location),
                label: Text("choose location"),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['location'],
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Text(
              data['time'],
              style: TextStyle(
                fontSize: 70.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
