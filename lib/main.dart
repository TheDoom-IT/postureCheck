import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
        title: 'My app',
      )
  );
}

class MyClock extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width/4.0*3,
            color: Colors.lightGreen,
            child: Text("Place for clock"),
          )
        ),
        Expanded(
          child: Container(),
        ),
      ]
    );
  }
}

class MyButton extends StatelessWidget{
  MyButton({this.buttonString,this.onPressed});

  final buttonString;
  final VoidCallback onPressed;

  final buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: buttonString == "Start" ? null : buttonColor,
        border: Border.all(
          color: buttonColor,
          width: 2,
        ),
      ),
      child: FlatButton(
        child: Text(buttonString),
        onPressed: onPressed,
      )
    );
  }
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  Timer timer;

  _MyAppState(){
    timer = new Timer.periodic(new Duration(seconds: 1), _increment);
  }

  var buttonString = "Start";
  int seconds = 0;
  int minutes = 0;
  bool countActive = false;

  void changeString(){
    setState(() {
      countActive = !countActive;
      buttonString = buttonString == "Start" ? "Stop" : "Start";
    });
  }

  void _increment(Timer timer) {
    if (countActive) {
      setState(() {
        seconds++;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(seconds.toString()),
            ),
          ),
        body: Center(
            child: Column(
                children: <Widget>[
                  //Clock part
                  Expanded(
                    flex: 4,
                    child: MyClock(),
                  ),
                  //Button part
                  Expanded(
                    flex: 1,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(color: Colors.red,),
                          ),
                           Container(
                             height: 50,
                             width: 150,
                             child: MyButton(
                               buttonString: buttonString,
                               onPressed: changeString,
                             ),
                           ),
                          Expanded(
                            child: Container(color: Colors.red,),
                          )

                        ]
                      ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}

