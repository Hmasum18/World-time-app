import 'package:flutter/material.dart';
import 'package:world_time_app/utils/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Dhaka',flag: 'ban.png',location: "Dhaka"),
    WorldTime(url: 'America/New_York', flag: 'usa.png',location: 'New York'),
    WorldTime(url: 'Asia/Kolkata', flag: 'ind.png',location: 'Kolkata'),
    WorldTime(url: 'Europe/London',flag: 'uk.png', location: 'London'),
    WorldTime(url: 'Asia/Tokyo',flag: 'japan.jpg',location: 'Tokyo'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    //we got the the time data so now navigate back to home
    Navigator.pop(context, {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDay' : instance.isDay,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose location'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              child: Card(
                child: ListTile(
                  onTap: (){
                   updateTime(index); //we want time at this index
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('images/${locations[index].flag}'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(locations[index].location),
                ),
              ),
            );
          }
      ),
    );
  }
}
