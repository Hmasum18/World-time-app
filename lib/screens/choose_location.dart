import 'package:flutter/material.dart';
import 'package:world_time_app/utils/world_time.dart';

class ChooseLocation extends StatefulWidget{
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Map routeData = {};

  List<WorldTime> locations = [
    WorldTime(relativePath: 'Asia/Dhaka', flag: 'ban.png', location: "Dhaka"),
    WorldTime(relativePath: 'America/New_York', flag: 'usa.png', location: 'New York'),
    WorldTime(relativePath: 'Asia/Kolkata', flag: 'ind.png', location: 'Kolkata'),
    WorldTime(relativePath: 'Europe/London', flag: 'uk.png', location: 'London'),
    WorldTime(relativePath: 'Asia/Tokyo', flag: 'japan.jpg', location: 'Tokyo'),
    WorldTime(relativePath: 'Australia/Sydney', flag: 'aus.jpg', location: 'Sydney'),
  ];

  @override
  Widget build(BuildContext context) {
    routeData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose location'),
        //centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 1, horizontal: 1),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage('images/${locations[index].flag}'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(locations[index].location),
                  subtitle: Text("City"),
                  selected: locations[index].location ==
                      routeData['location'],
                  selectedTileColor: Colors.greenAccent,
                  onTap: () {
                    _updateLocation(index); //we want time at this index
                  },
                ),
              ),
            );
          }),
    );
  }

   void _updateLocation(index){
    WorldTime instance = locations[index];
    //we got the the time data so now navigate back to home
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'relativePath': instance.relativePath,
    });
  }
}
