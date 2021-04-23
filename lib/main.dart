import 'package:cat_and_dog/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CD Detector",
      home: MySplashScreen(),
    );
  }
}
