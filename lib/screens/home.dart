import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/utils/world_time.dart';

final String TAG = 'Home->';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //a state variable
  WorldTime worldTime;

  @override
  void initState() {
    super.initState();
    //init state variable
    worldTime = new WorldTime(
        location: "Dhaka", flag: 'dhaka.png', relativePath: 'Asia/Dhaka');
  }

  Future<WorldTime> _fetchData(WorldTime worldTime) async {
    print("$TAG : fetchData(): ${worldTime.location}");
    await worldTime.fetchTime();
    return worldTime;
  }

  @override
  Widget build(BuildContext context) {
    print("$TAG build(): $worldTime");
    //receives the map that we passed form Loading page as argument
    return FutureBuilder(
        future: _fetchData(worldTime),
        builder: (context, AsyncSnapshot<WorldTime> snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            );
          } else {
            Color bgColor = (worldTime.isDay == null || worldTime.isDay)
                ? Colors.blue
                : Colors.indigo[400];

            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
                //centerTitle: true,
                backgroundColor: bgColor, //change between day and night
              ),
              body: _getBody(worldTime),
              floatingActionButton: _changeLocationButton(),
            );
          }
        });
  }

  Widget _getBody(WorldTime worldTime) {
    print("$TAG _getBody(): ${worldTime.toString()}");

    String currentTime = worldTime.time == null ? "Error!" : worldTime.time;
    String currentDate = worldTime.date == null ? "Error!" : worldTime.date;

    //set the background
    bool isDay = worldTime.isDay;

    String bgImage = (isDay == null || isDay) ? 'day.jpg' : 'night.jpg';

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/$bgImage'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 110, 0, 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  //location text
                  worldTime.location,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            getTextView(currentTime, 70),
            SizedBox(
              height: 20.0,
            ),
            getTextView(currentDate, 20),
          ],
        ),
      ),
    );
  }

  Widget getTextView(String str, double fontSize) {
    return Text(
      str,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }

  Widget _changeLocationButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      child: Transform.scale(
        scale: 1.2,
        child: FloatingActionButton(
          child: Icon(Icons.edit_location, size:30,),
          onPressed: _chooseLocation,
          backgroundColor: worldTime==null||worldTime.isDay? Colors.indigo[400] : Colors.blue,
        ),
      ),
    );
    /* return Opacity(
      opacity: 0.7,
      child: TextButton.icon(
        onPressed: _chooseLocation, //call chooseLocation function
        icon: Icon(Icons.edit_location),
        label: Text("Choose location"),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(4),
            backgroundColor: Colors.pinkAccent,
            textStyle: TextStyle(
              color: Colors.black,
            )),
      ),
    );*/
  }

  /// this method is called when choose location button is pressed
  void _chooseLocation() async {
    //go to choose location page and wait for the results
    // return the result when Navigator.pop() is called from choose_location screen.
    dynamic result = await Navigator.pushNamed(
      context, //build context
      '/choose_location', //routeName
      arguments: {
        "location": worldTime.location,
      },
    );

    // is location is not changed
    // then change the state variable worldTime
    if (result['location'] == worldTime.location) {
      print('$TAG: user did not selected any new time zone');
      return;
    }

    //setState update the dat in runtime
    super.setState(() {
      //get the result and update it
      try {
        worldTime = new WorldTime(
          location: result['location'],
          flag: result['flag'],
          relativePath: result['relativePath'],
        );
      } catch (e) {
        print('$TAG: user did not selected any new time zone');
      }
    });
  }
}
