import 'dart:async';

import 'package:flutter/material.dart';
import 'package:podomoro_app/widget/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const maxSeconds = 59;
  static const maxMinutes = 25;
  static const maxMinutesBreak = 5;
  bool isActive = false;
  bool isBreak = false;
  String? timeSeconds;
  String? timeMinutes;
  int minutes = maxMinutes;
  int seconds = 0;
  Timer? timer;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: color(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("PODOMORO TIMER", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),),
           Container(height: 10),
           Text(textChanger(), style: TextStyle(color: Colors.white, fontSize: 20),),
            Container(height: 40),
           buildTime(),
            Container(height: 40,),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [startButton(),Container(width: 20,),resetButton()],),


          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget startButton(){
    return ButtonWidget(
        text:"Start Timer",
      onClicked: () {
          if(!isActive) {
            startTimer();
          }else {
            null;
          }
      }
      ,

    );
  }

  Widget resetButton(){
    return ButtonWidget(text: "Reset Time", onClicked: (){
resetTimer();
    });
  }

  Widget buildTime(){
    return Text(
      timerText()
    ,style: const TextStyle(fontSize: 50, color: Colors.white),);
  }
  void timeSet(){
    if(isBreak){
      minutes = maxMinutesBreak;
    }else{
      minutes = maxMinutes;
    }
  }
  void startTimer(){
    isActive = true;
    timeSet();
    timer = Timer.periodic(const Duration(seconds:1), (_){
      setState(() {

        if(isBreak){
          if(seconds != 0) {
            seconds--;
          }
          if(seconds == 0){
            seconds = maxSeconds;
            minutes--;
          }
          if(minutes < 0){
            isBreak = false;
            minutes = maxMinutes;
            seconds = 0;
            isActive = false;

            timer!.cancel();
          }
        }else{
          if(seconds != 0) {
            seconds--;
          }
          if(seconds == 0){
            minutes--;
            seconds = maxSeconds;

          }
          if(minutes < 0){
            isBreak = true;
            minutes = maxMinutes;
            seconds = 0;
            isActive = false;
            timer!.cancel();
          }}});
    });
  }
  void resetTimer(){
    isActive = false;
    setState(() {
      timer!.cancel();
      seconds = 0;
      minutes = 25;
    });
  }

  timerText(){

    if(seconds < 10 && minutes < 10){
      return '0$minutes:0$seconds';
    } else if(seconds < 10){
      return '$minutes:0$seconds';
    } else if(minutes < 10){
      return '0$minutes:$seconds';
    }else{
      return '$minutes:$seconds';
    }
  }
  color(){
    if(isBreak){
      return Colors.green;
    }else{
      return Colors.amber;
    }
  }
  textChanger(){
    if(isBreak){
      return "It's time to relax, but not so much ok?";
    } else{
      return "It's time to focus!!!";
    }
  }
}
