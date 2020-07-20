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
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments ;
    print('$TAG : $data');

    //set the background
    bool isDay = data['isDay'];
   // isDay = false;
    String bgImage = isDay ? 'day.jpg' : 'night.jpg';
    Color bgColor =isDay ? Colors.blue : Colors.indigo[900];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: bgColor, //change between day and night
      ),
      body:  Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$bgImage'),
                //image: AssetImage('images/my_profile_pic.jpg'),
                fit: BoxFit.cover,
              ),
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,110,0,0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                color: Colors.pinkAccent,
                onPressed: () async{
                  //go to choose location page and wait for the results
                  dynamic result = await Navigator.pushNamed(context, '/choose_location');
                  setState(() {
                    data = {
                      'location' :result['location'],
                      'flag' : result['flag'],
                      'time' : result['time'],
                      'isDay' : result['isDay'],
                    };
                  });

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
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 70.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
