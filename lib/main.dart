import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title: 'My app',
  ));
}

class MyClock extends StatelessWidget {
  final int seconds;
  final VoidCallback addButton;
  final VoidCallback minusButton;
  final countActive;
  final myText;

  MyClock({this.seconds, this.addButton, this.minusButton, this.countActive})
      : myText = ((seconds / 60).floor() < 10 ? '0' : '') +
            (seconds / 60).floor().toString() +
            ':' +
            (seconds % 60 < 10 ? '0' : '') +
            (seconds % 60).toString();

  @override
  Widget build(BuildContext context) {
    //shows only minutes and buttons to change them
    if (countActive == false) {
      return Column(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Expanded(
            flex: 2,
            child: Container(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white60,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white60,
                  onPressed: addButton,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    (seconds / 60).floor().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                  border: Border.all(
                    color: Colors.white60,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.white60,
                  onPressed: minusButton,
                ),
              ),
            ]))),
        Expanded(
          child: Container(),
        ),
      ]);
    }
    return Center(
      child: Text(
        myText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 100,
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({this.buttonString, this.onPressed});

  final buttonString;
  final VoidCallback onPressed;

  final buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}

class MySwitch extends StatelessWidget {
  MySwitch({this.darkenScreen, this.onChanged});

  final bool darkenScreen;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(children: [
        Expanded(child: Container()),
        Switch(
          activeColor: Colors.white,
          value: darkenScreen,
          onChanged: onChanged,
        ),
        Text('Darken screen',
            style: TextStyle(
              color: Colors.white70,
            ))
      ]),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer timer;
  double brightnessSaved;
  int secondsToCount = 60;
  int minutesSet = 1;
  bool countActive = false;
  bool darkenScreen = false;
  AudioCache audio = AudioCache();
  var buttonString = "Start";

  _MyAppState() {
    getBrightness();
    timer = new Timer.periodic(new Duration(seconds: 1), decrementTimer);
    audio.load('sound.wav');
  }

  void getBrightness() async {
    brightnessSaved = await Screen.brightness;
  }

  void changeDarken(bool value) {
    setState(() {
      darkenScreen = value;
    });
  }

  void playSound() {
    audio.play('sound.wav');
  }

  void setTime() {
    secondsToCount = minutesSet * 60;
  }

  void startStopCounter() {
    setState(() {
      countActive = !countActive;
      buttonString = buttonString == "Start" ? "Stop" : "Start";
      setTime();

      if (countActive) {
        Screen.keepOn(true);

        if (darkenScreen) {
          Screen.setBrightness(0);
        }
      } else {
        Screen.keepOn(false);
        Screen.setBrightness(brightnessSaved);
      }
    });
  }

  void decrementTimer(Timer timer) {
    if (countActive) {
      secondsToCount--;
      if (secondsToCount == 0) {
        playSound();
        setTime();
      }
      setState(() {});
    }
  }

  void addMinute() {
    minutesSet++;
    if (minutesSet > 59) {
      minutesSet = 1;
    }
    setTime();
    setState(() {});
  }

  void substractMinute() {
    minutesSet--;
    if (minutesSet < 1) {
      minutesSet = 59;
    }
    setTime();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Column(children: <Widget>[
          //Clock part
          Expanded(
            flex: 3,
            child: MyClock(
              seconds: secondsToCount,
              addButton: addMinute,
              minusButton: substractMinute,
              countActive: countActive,
            ),
          ),
          //Button part
          Expanded(
            child: Column(children: [
              MyButton(
                buttonString: buttonString,
                onPressed: startStopCounter,
              ),
              MySwitch(darkenScreen: darkenScreen, onChanged: changeDarken)
            ]),
          ),
        ]),
      ),
    );
  }
}
