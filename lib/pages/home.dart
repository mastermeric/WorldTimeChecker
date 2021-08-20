
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map receivedData = {};
  String bgImage = "";
  Color bgColor = Colors.blue;

  @override
  Widget build(BuildContext context) {

    // Arguman list halinde ddatalari bu Route a al ----------------------------
    // setState icinde yapmaya gerek yok cunku sadece Build icinde tetiklenir..
    if(receivedData.isEmpty) {
      receivedData = ModalRoute.of(context).settings.arguments;// INITIAL DATA !
    }
    else {
      receivedData = receivedData;
    }

    if(receivedData["isDayTime"] != null) {
      bgImage = receivedData["isDayTime"] ? "assets/daytime.jpg": "assets/nighttime.jpg";
      bgColor = receivedData["isDayTime"] ? Colors.blue : Colors.indigo;
    }
    //--------------------------------------------------------------------------

    return Scaffold(
      //appBar: AppBar(title: Center(child: Text("This is Home Page"))) ,  Anasayfada AppBar olursa <-- ile kontrolsuz cikis olur
      backgroundColor: bgColor,
      body:
           SafeArea(
             child: Container(
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage('$bgImage'),
                   fit: BoxFit.cover
                 )
               ),
               child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("This is Home Page")
                  ],),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    FlatButton.icon(
                        onPressed: () async {
                          //--------------- asyn bir sekilde ekrandan pop ile geri gelince yeniden rebuid yap
                          var res = await Navigator.pushNamed(context, '/location');
                          setState(() {
                            receivedData = res; // GUNCEL DATAYI YAZ !
                          });
                          //---------------
                        } ,
                        icon: Icon(Icons.edit_location),
                        label: Text("Edit Lcoation"))
                  ],),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(receivedData["location"],style: TextStyle(fontSize: 20),)
                  ],),
                  SizedBox(height: 20),
                  Text(receivedData["time"], style: TextStyle(fontSize: 60),)
                ],
          ),
             ),
           ),
    );
  }
}
