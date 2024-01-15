import 'package:flutter/material.dart';
import 'package:qr/Components/Base.dart';
import 'dart:async';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Login.dart';
import 'package:qr/Utils/Network.dart';

int splashSure = 1000;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? session = "";

  Future<void> oku() async
  {
    session = await storage.read(key: "session");
    Future.delayed(Duration(milliseconds: splashSure), ()
    {
      if(session == "1")
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()));
      }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    oku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.lightGrey,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          child: Image.asset("lib/Assets/Images/logo.png"),
        ),
      ),
    );
  }
}