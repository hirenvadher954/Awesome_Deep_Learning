import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:ultimate_machine_learning/CatVsDog.dart';
import 'package:ultimate_machine_learning/Home.dart';

class SplashDisplay extends StatefulWidget {
  @override
  _SplashDisplayState createState() => _SplashDisplayState();
}

class _SplashDisplayState extends State<SplashDisplay> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: Home(),
      title: Text(
        "Let's fun with ML",
        style: TextStyle(
            color: Color(0XFFE99600),
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
      image: Image.asset('assets/mylogo.png',),
      backgroundColor: Colors.black,
      photoSize: 100,
      loaderColor: Color(0XFFEEDA28),
    );
  }
}
