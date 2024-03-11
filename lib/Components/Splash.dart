import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Components/Splash2.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';

int splashSure = 1000;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? session = "";

  Future<void> gec() async
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Splash2()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    gec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.mainColor,
      body: Center(
        child: SvgPicture.asset("lib/Assets/Images/logo_buyuk.svg",width: 125,)
      ),
    );
  }
}