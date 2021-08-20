import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location ; //location name for the UI
  String time ;
  String flag ;// utl to assest folder of flag image
  String url ; //  location url for api endpoint
  bool isDayTime = false;

  WorldTime(String url, String location,String flag ){
    this.location = location;
    this.flag = flag;
    this.url = url;
  }

  //NOT:  return degeri olmayan async metotlar  diger class alrdan cagirabilmek icin illaki bir return gerektirir..
  //Future<void>  tipi bir return degeri bu nedenle kullanildi..  VEYA alternatif cozum return ile  string time dondurulebilir.
   Future<void> getTime() async {
    try{
      //TODO:  IOS icinde  secure call ayarı yapılacak !
      Response response = await get("http://worldtimeapi.org/api/timezone/"+url);
      Map data = jsonDecode(response.body);
      String datetime =  data["datetime"];
      String offset =  data["utc_offset"].toString().substring(0,3);
      DateTime now = DateTime.parse(datetime);
      now = now.add( Duration(hours: int.parse(offset) ));  // Offset varsa saa olarak ekleriz..
      isDayTime = now.hour>6 && now.hour<20  ? true:false;
      time = DateFormat.jm().format(now);  // Human readable kutuphane kullandik.. Ör :  9:17 PM
    }
    catch(e) {
      print("ERROR => " + e.toString());
      time = "ERROR => " + e.toString();
    }
  }
}