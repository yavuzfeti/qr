import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qr/Components/Message.dart';

class Internet
{
  static late StreamSubscription<ConnectivityResult> _dinleyici;

  static bool internet = true;

  static void control() async
  {
    internet = await InternetConnectionChecker().hasConnection;
    dialog(internet);
  }

  static void gecBaslat(int gecikme)
  {
    Future.delayed(Duration(milliseconds: gecikme),() {baslat();});
  }

  static void baslat()
  {
    control();
    _dinleyici = Connectivity().onConnectivityChanged.listen((sonuc)
    {
      internet = (sonuc == ConnectivityResult.mobile || sonuc == ConnectivityResult.wifi);
      dialog(internet);
    });
  }

  static void dialog(bool internet) async
  {
    if(!internet)
    {
      Message.show(
          "Ağ bağlantısı yok",
          icon: Icons.wifi_off_rounded
      );
    }
  }
}