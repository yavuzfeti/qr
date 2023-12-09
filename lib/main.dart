import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr/Components/Internet.dart';
import 'package:qr/Components/Splash.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Permissions.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
bool debugMode = true;

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  //Permissions.allRequests();

  Internet.gecBaslat(splashSure + 1000);

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: debugMode,
      title: "Personel Takip Sistemi",
      theme: Themes.theme,
      navigatorKey: navKey,
      home: const Splash(),
    ),
  );
}