import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:world_time_app/services/world_time.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}


class _LoadingPageState extends State<LoadingPage> {

  String time = "loading..";

  void getWorldTime() async {
    String _location ="UK London";
    String _flag ="london.png";
    String _url ="Europe/London";

    //ORNEK ULKE: Londn ile basla..
    WorldTime timeService = new WorldTime( _url, _location, _flag);
    await timeService.getTime();

    //Navigator.pushNamed(context, "/Home");// yeni Route u stack in en ustune getirir..
    Navigator.pushReplacementNamed(// yeni Route u stack deki Route ile replace eder.. Ve Data da gonderebiliriz..
        context,
        "/home",
        arguments: {
          'location': timeService.location,
          'flag': timeService.flag,
          'time': timeService.time,
          'isDayTime' : timeService.isDayTime
        }
    );

    // print("time ==> " + timeService.resultTime);
    // setState(() { time = timeService.resultTime;});
  }

  @override
  void initState() {
    super.initState();
    getWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
          //child: Text("loading...")
          child:  SpinKitRing(color: Colors.white,size: 100.0)
      ),
    );
  }
}
