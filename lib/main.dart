import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr/Components/Internet.dart';
import 'package:qr/Components/Splash.dart';
import 'package:qr/Components/Themes.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

String dateToDartTrans(dynamic date) => (DateFormat("dd.MM.yyyy").format((DateTime.parse(date.toString())))).toString();
String key = "qrpdks_4iJZafkXr1w87NMU3XXguIPYtqw5NP";

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
      title: "QrPdks",
      theme: Themes.theme,
      navigatorKey: navKey,
      home: const Splash(),
    ),
  );
}