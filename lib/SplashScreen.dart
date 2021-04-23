import 'package:cat_and_dog/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        "Cat and Dog",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      image: Image.asset("assets/catdog.png"),
      photoSize: 200,
    );
  }
}
