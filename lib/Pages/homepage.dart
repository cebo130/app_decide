
import 'package:flutter/material.dart';

import '../wheel/wheelhomepage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> names = [
    "Nothing",
    "bath",
    "study",
    "play",
    "londi",
    "listen to music",
    "Jog",
    //"go to the gym",
    //"dance",
    // "sleep",
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  width: screenWidth-130,
                  height: 50,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text("Spin Wheel"),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WheelHomePage(names: names,)));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

