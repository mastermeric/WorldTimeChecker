import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocationPage extends StatefulWidget {
  @override
  _ChooseLocationPageState createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {

  List<WorldTime> locations =  [
    WorldTime('America/Chicago','Chicago','usa.png'),
    WorldTime('Asia/Seoul','Seoul','south_korea.png'),
    WorldTime('Europe/London','London','uk.png'),
    WorldTime('Europe/Berlin','Berlin','germany.png')
  ];

  void updateTime(index) async {
    //WorldTime myWorldTime = new WorldTime(locations[index].location, locations[index].flag, locations[index].url);
    WorldTime myWorldTime = locations[index];
    await myWorldTime.getTime();

    //-------------------------- : navigate head back to Home page !!!
    Navigator.pop(context , {
      'location': myWorldTime.location,
      'flag': myWorldTime.flag,
      'time': myWorldTime.time,
      'isDayTime' : myWorldTime.isDayTime
    });
    //--------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Choose a location"),centerTitle: true,),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                //print(locations[index].location);
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/${locations[index].flag}"),
              ),
            ),
          );
        },
      )
    );
  }
}
