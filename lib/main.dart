import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
        title: 'My app',
      )
  );
}

class ChooseTime extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(
      child: Text('Aldasda'),
    );
  }
}

class MyButton extends StatelessWidget{
  MyButton({this.buttonString,this.onPressed});

  final buttonString;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context){
    return IconButton(
      icon: Text(buttonString),
      onPressed: onPressed,
      iconSize: 100,
      alignment: Alignment.center,
    );
  }
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

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

  void _increment() {
    setState(() {
      //do sth
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MyApp'),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                  Container(
                    child: ChooseTime(),
                    height: 100,
                  ),
                  Expanded(
                      child: Container(
                        color: Colors.red,
                        width: 100,
                      )
                  ),
                  Container(
                    child: MyButton(
                      buttonString: buttonString,
                      onPressed: changeString,
                    ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}

