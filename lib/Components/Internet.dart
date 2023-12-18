import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Internet
{
  static late StreamSubscription<ConnectivityResult> _dinleyici;

  static bool servis = false;

  static bool internet = true;

  static bool dialogDurum = false;

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
    if(!servis)
    {
      _dinleyici = Connectivity().onConnectivityChanged.listen((sonuc)
      {
        internet = (sonuc == ConnectivityResult.mobile || sonuc == ConnectivityResult.wifi);
        dialog(internet);
      });
      servis = true;
    }
  }

  static void durdur()
  {
    if(servis)
    {
      _dinleyici?.cancel();
      servis = false;
      dialogDurum = false;
    }
  }

  static void dialog(bool internet) async
  {
    if(!internet && !dialogDurum)
    {
      dialogDurum = true;
      Alert.show(
          content: Container(
            height: 175,
            padding: const EdgeInsets.all(25),
            child: const Column(
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 50,
                  color: Themes.light,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Themes.light,fontSize: 15),
                    "Lütfen ağ bağlantınızı kontrol edin")
              ],
            ),
          ),
      );
    }
    else
    {
      if(dialogDurum && internet)
      {
        Navigator.of(navKey.currentState!.context).pop();
        dialogDurum = false;
      }
    }
  }
}