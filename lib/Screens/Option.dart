import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
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
    if(widget.title == "Konumlu Uzaktan")
    {
      Permissions.locationRequest();
    }
    else if(widget.title == "QR Okutmalı")
    {
      Permissions.cameraRequest();
    }
    Future.delayed(Duration(milliseconds: 250),okut);
  }

  String qr = "";

  cikisqr() async
  {
    if(Permissions.camera)
    {
      qr = await FlutterBarcodeScanner.scanBarcode(
        '#000000',
        "İptal",
        true,
        ScanMode.QR,
      );
      print(qr);
    }
  }

  girisqr() async
  {
    if(Permissions.camera)
    {
      qr = await FlutterBarcodeScanner.scanBarcode(
        '#000000',
        "İptal",
        true,
        ScanMode.QR,
      );
      print(qr);
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
