import 'package:flutter/material.dart';
import 'package:qr/main.dart';

class Navigation
{
  go(StatefulWidget route) => Navigator.push(navKey.currentState!.context, MaterialPageRoute(builder: (context) => route));

  goNoBack(StatefulWidget route) => Navigator.pushReplacement(navKey.currentState!.context, MaterialPageRoute(builder: (context) => route));

  back() => Navigator.pop(navKey.currentState!.context);

  goClear(StatefulWidget route) =>
      Navigator.pushAndRemoveUntil(
        navKey.currentState!.context,
        MaterialPageRoute(builder: (context) => route),
            (Route<dynamic> route) => false,
      );
}