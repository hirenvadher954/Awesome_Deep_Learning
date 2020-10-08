import 'package:flutter/material.dart';
import 'package:ultimate_machine_learning/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Ultimate Machine Learning',
      debugShowCheckedModeBanner: false,
      home: SplashDisplay(),
    );
  }
}
