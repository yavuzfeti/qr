import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qr/Components/Internet.dart';
import 'package:qr/Components/Splash.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/NotificationBackground.dart';
import 'package:qr/firebase_options.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

String monthStr(dynamic date) => DateFormat.MMMM('tr_TR').format(DateTime.parse(date.toString())).toString();
String dateToDartTrans(dynamic date) => (DateFormat("dd.MM.yyyy").format((DateTime.parse(date.toString())))).toString();
String key = "qrpdks_4iJZafkXr1w87NMU3XXguIPYtqw5NP";

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationBackground.start();

  await initializeDateFormatting('tr_TR', null);

  Internet.gecBaslat(splashSure + 1000);

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );

  runApp(
    MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
              textScaler: const TextScaler.linear(1.0)
          ),
          child: child!,
        );
      },
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate,],
      supportedLocales: const [Locale('tr', 'TR')],
      debugShowCheckedModeBanner: kDebugMode,
      title: "QrPdks",
      theme: Themes.theme,
      navigatorKey: navKey,
      home: const Splash(),
    ),
  );
}