import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/Utils/Permissions.dart';

class Option extends StatefulWidget {

  String title;
  Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

  okut() async
  {
    if(widget.title == "Konumlu Uzaktan")
    {
      await Permissions.locationRequest();
    }
    else if(widget.title == "QR Okutmalı")
    {
      await Permissions.locationRequest();
      await Permissions.cameraRequest();
    }
    id = await storage.read(key: "id");
    if(Permissions.location)
    {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }
    await Sheet.show(
        [
          if(widget.title == "Konumlu Uzaktan")
            Text("QR kod okutmadan uzaktan, mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
          if(widget.title == "QR Okutmalı")
            Text("QR kod ile mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
          ElevatedButton(
            onPressed: ()
            {
              if(widget.title == "Konumlu Uzaktan")
              {
                giriskonum();
              }
              else if(widget.title == "QR Okutmalı")
              {
                girisqr();
              }
            },
            child: Text("Giriş Yap"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.dark
            ),
            onPressed:()
            {
              if(widget.title == "Konumlu Uzaktan")
              {
                cikiskonum();
              }
              else if(widget.title == "QR Okutmalı")
              {
                cikisqr();
              }
            },
            child: Text("Çıkış Yap"),
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250),okut);
  }

  String qr = "";
  String? id = "";
  dynamic response;
  dynamic position;
  String key = "qrpdks_4iJZafkXr1w87NMU3XXguIPYtqw5NP";

  cikisqr() async
  {
    if(Permissions.camera)
    {
      qr = (await FlutterBarcodeScanner.scanBarcode(
        '#000000',
        "İptal",
        true,
        ScanMode.QR,
      )).substring(7);
      try
      {
        response = await Network("locations?user_id=$id&company_token=$qr&key=$key&coordinates=${position.latitude},${position.longitude}").get();
        await Network("logs?user_id=$id&token=$qr&key=$key").post("");
      }
      catch (e)
      {
        Message.show("Bir hata oluştu.");
      }
    }
  }

  girisqr() async
  {
    if(Permissions.camera)
    {
      qr = (await FlutterBarcodeScanner.scanBarcode(
        '#000000',
        "İptal",
        true,
        ScanMode.QR,
      )).substring(7);
      try
      {
        response = await Network("locations?user_id=$id&company_token=$qr&key=qrpdks_4iJZafkXr1w87NMU3XXguIPYtqw5NP&coordinates=${position.latitude},${position.longitude}").get();
      }
      catch (e)
      {
        Message.show("Bir hata oluştu.");
      }
    }
  }

  cikiskonum() async
  {
    if(Permissions.location)
    {
    }
  }

  giriskonum() async
  {
    if(Permissions.location)
    {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar(widget.title),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("lib/Assets/Images/logo.png"),
              ElevatedButton(
                onPressed: okut,
                child: Text("Okut"),
              ),
            ],
          ),
        ),
      )
    );
  }
}
