import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Login.dart';
import 'package:qr/Utils/Network.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {

  String? session = "";

  Future<void> baslat() async
  {
    if(session == "1")
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()));
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.lightGrey,
      body: Column(
        children: [
          Center(
              child: SvgPicture.asset("lib/Assets/Images/splash2.svg")
          ),
          Container(
            decoration: BoxDecoration(
              color: Themes.orange,
              borderRadius: BorderRadius.circular(100)
            ),
            child: IconButton(
              iconSize: 40,
              onPressed: baslat,
              icon: Icon(Icons.keyboard_arrow_right_rounded,color: Themes.light,),
            ),
          )
        ],
      ),
    );
  }
}
