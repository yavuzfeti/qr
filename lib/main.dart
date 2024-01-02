import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr/Components/Internet.dart';
import 'package:qr/Components/Splash.dart';
import 'package:qr/Components/Themes.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Internet.gecBaslat(splashSure + 1000);

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: "Personel Takip Sistemi",
      theme: Themes.theme,
      navigatorKey: navKey,
      home: const Splash(),
    ),
  );
}