import 'dart:math';

import 'package:flutter/material.dart';

import '../Pages/homepage.dart';
import 'board_view.dart';
import 'model.dart';

class WheelHomePage extends StatefulWidget {
  WheelHomePage({required this.names});
 final List<String> names;
  @override
  State<StatefulWidget> createState() {
    return _WheelHomePageState(names: names);
  }
}

class _WheelHomePageState extends State<WheelHomePage>
    with SingleTickerProviderStateMixin {
  _WheelHomePageState({required this.names});
  final List<String> names;

  double _angle = 0;
  double _current = 0;
  late AnimationController _ctrl;
  late Animation _ani;

  List<Luck> _items = [

    //Luck("cebo", Colors.white),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }
  bool pressed = false;
  String check = '';
  @override   // _items = [
  //   Luck(names[0], Colors.white),
  //   Luck(names[1], Colors.accents[0]),
  //   Luck(names[2], Colors.accents[2]),
  //   Luck(names[3], Colors.accents[4]),
  //   Luck(names[4], Colors.accents[6]),
  //   Luck(names[5], Colors.accents[8]),
  //   Luck(names[6], Colors.accents[10]),
  //   //Luck(names[7], Colors.black),
  //   //Luck(names[8], Colors.accents[14]),
  //   //Luck(names[9], Colors.lightGreenAccent),
  // ];
  Widget build(BuildContext context) {

    for(int i=0; i<names.length; i++){
      _items = [
        Luck(names[i], Colors.white),
      ];
      print(" ${names[i]} **************************///////////");
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(36), // Set this height
        child: AppBar(
            title: Text('${names[3]} ',style: TextStyle(color: Colors.tealAccent),),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.black, Colors.pink, Colors.black]),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.tealAccent,
              ),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              },
            )
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black,Colors.pink, Colors.black])),
        child: Stack(
          children: [
            Positioned(
              child: pressed ? SizedBox.shrink() : Text('',style: TextStyle(color: Colors.pink,fontSize: 20),),
              left: 25,
              top: 26,
            ),
            Positioned(
              child: pressed ? Text('',style: TextStyle(color: Colors.tealAccent,fontSize: 20),): SizedBox.shrink(),
              left: 100,
              top: 86,
            ),
            AnimatedBuilder(
                animation: _ani,
                builder: (context, child) {
                  final _value = _ani.value;
                  final _angle = _value * this._angle;
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildResult(_value),
                      BoardView(items: _items, current: _current, angle: _angle),
                      _buildGo(),
                      SizedBox(height: 10,),
                      //_buildResult(_value),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  _buildGo() {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "GO",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: (){
          _animation();

          setState(() {
            pressed = true;
          });
        },
      ),
    );
  }

  _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  int _calIndex(value) {
    var _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
    String _asset = _items[_index].asset;
    List<Color> col = <Color>[
      Colors.white,
      Colors.accents[0],
      Colors.accents[2],
      Colors.accents[4],
      Colors.accents[6],
      Colors.accents[8],
      Colors.accents[10],
      Colors.accents[12],
      Colors.accents[14],
      Colors.lightGreenAccent,
    ];

    String names2 = '';
    names2 = names.elementAt(_index);
    check = names2;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20,),
          pressed ? Text(
            "",
            style: TextStyle(color: Colors.pink,fontSize: 18),
          ) : SizedBox.shrink(),
          //pressed ? Icon(Icons.arrow_drop_down_sharp,color: col.elementAt(_index),size: 30,): SizedBox.shrink(),
          pressed ? Text(
            "You must....",
            style: TextStyle(color: col.elementAt(_index),fontSize: 18),
          ) : SizedBox.shrink(),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.bottomCenter,
            child: pressed ? GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: col.elementAt(_index),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: col.elementAt(_index),
                ),
                // color: Colors.blueGrey,
                height: 40.0,
                //width: 80.0,
                child: Center(child: Text( "$names2",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),//Image.asset(_asset, height: 70, width: 70,fit: BoxFit.cover,),
              ),
              onTap: (){
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyMatch(),),
                );*/
              },
            ) : SizedBox.shrink(),
          ),

        ],
      ),
    );
  }
}
class _MyColor {
  _MyColor(this.color, this.name);

  final Color color;
  final String name;
}