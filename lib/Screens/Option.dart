import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/Utils/Permissions.dart';
import 'package:qr/main.dart';

class Option extends StatefulWidget {

  String title;
  Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

  okut() async
  {
    Sheet.show(
        [
          SizedBox(height: 25,),
          if(widget.title == "Konumlu Uzaktan")
            Text("QR kod okutmadan uzaktan, mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Themes.grey),),
          if(widget.title == "QR Okutmalı")
            Text("QR kod ile mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Themes.grey),),
          ElevatedButton(
            onPressed: ()
            {
              if(widget.title == "Konumlu Uzaktan")
              {
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
                giriskonum();
              }
              else if(widget.title == "QR Okutmalı")
              {
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
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
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
                cikiskonum();
              }
              else if(widget.title == "QR Okutmalı")
              {
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
                cikisqr();
              }
            },
            child: Text("Çıkış Yap"),
          ),
          SizedBox(height: 25,)
        ]);
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
      position = await Geolocator.getCurrentPosition();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      okut();
    });
  }

  String qr = "";
  String? id = "";
  dynamic response;
  dynamic position;
  bool loading = false;

  success() async
  {
    await Sheet.show(
      [
        Text("İŞLEM BAŞARILI",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
        SvgPicture.asset("lib/Assets/Images/succes.svg"),
        Text("İşleminiz başarıyla gönderilmiştir.\nİşlem tarihiniz ${dateToDartTrans(DateTime.now())}",style: TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
        ElevatedButton(onPressed: (){Navigator.pop(context);Navigator.pop(context);}, child: Text("Ana Sayfa"))
      ]
    );
    setState(() {
      loading = false;
    });
  }

  err() async
  {
    await Sheet.show(
        [
          Text("İŞLEM BAŞARISIZ",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
          SvgPicture.asset("lib/Assets/Images/err.svg",width: 75,),
          Text("Cihaz belirlenen konumun dışındadır!\nLütfen QR kod ekranı deneyin",style: TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
          ElevatedButton(onPressed: (){Navigator.pop(context);okut();}, child: Text("Başla"))
        ]
    );
    setState(() {
      loading = false;
    });
  }

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
        response = await Network("locations-user?user_id=$id&company_token=$qr&key=$key&coordinates=${position.latitude},${position.longitude}").get();
        await Network("logs?user_id=$id&token=$qr&key=$key").post("");
        success();
      }
      catch (e)
      {
        err();
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
        await Network("locations-user?user_id=$id&company_token=$qr&key=$key&coordinates=${position.latitude},${position.longitude}").get();
        await Network("logs?user_id=$id&token=$qr&key=$key").post("");
        success();
      }
      catch (e)
      {
        err();
      }
    }
  }

  cikiskonum() async
  {
    if(Permissions.location)
    {
      try {
        String? token = await storage.read(key: "current_team_id");
        await Network("locations-user?user_id=$id&company_token=$token&key=$key&coordinates=${position.latitude},${position.longitude}").get();
        await Network("logs?user_id=$id&token=$token&key=$key").post("");
        success();
      }catch (e)
      {
        err();
      }
    }
  }

  giriskonum() async
  {
    if(Permissions.location)
    {
      try {
        String? token = await storage.read(key: "current_team_id");
        await Network("locations-user?user_id=$id&company_token=$token&key=$key&coordinates=${position.latitude},${position.longitude}").get();
        await Network("logs?user_id=$id&token=$token&key=$key").post("");
        success();
      }catch (e) {
        err();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar(widget.title),
      body: Center(
        child: loading ? CircularProgressIndicator() :
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset("lib/Assets/Images/logo.svg"),
                  Text("QR PDKS",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              TextButton(onPressed: (){okut();},
                  child: Text("Devam etmek için tıkla")
              )
            ],
          ),
        ),
      )
    );
  }
}
