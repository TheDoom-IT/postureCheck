import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
        title: 'My app',
      )
  );
}

class MyClock extends StatelessWidget {

  final int seconds;
  final int minutes;

  MyClock({this.minutes,this.seconds});

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
                child: Text(minutes.toString() + ' ' + seconds.toString()),
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
    timer = new Timer.periodic(new Duration(seconds: 1), _decrement);
    audio.load('sound.wav');
  }
  var buttonString = "Start";
  int secondsCurr = 5;
  int minutesCurr = 0;
  int secondsSaved = 5;
  int minutesSaved = 0;
  bool countActive = false;
  AudioCache audio = AudioCache();

  bool isCountEnd()
  {
    return secondsCurr == 0 && minutesCurr == 0;
  }

  void playSound() {
    audio.play('sound.wav');
  }
  
  void resetTime(){
    secondsCurr = secondsSaved;
    minutesCurr = minutesSaved;
  }

  void startStopCounter(){
    setState(() {
      countActive = !countActive;
      buttonString = buttonString == "Start" ? "Stop" : "Start";

      if(countActive) {
          secondsSaved = secondsCurr;
          minutesSaved = minutesCurr;
        }
    });
  }

  void _decrement(Timer timer) {
    if(countActive) {
      secondsCurr--;
      if(isCountEnd()) {
          playSound();
          resetTime();
        }

      setState(() {});
    }
    }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(secondsCurr.toString()),
            ),
          ),
        body: Center(
            child: Column(
                children: <Widget>[
                  //Clock part
                  Expanded(
                    flex: 4,
                    child: MyClock(seconds: secondsCurr,minutes: minutesCurr,),
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
                               onPressed: startStopCounter,
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

