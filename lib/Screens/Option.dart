import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/Utils/Permissions.dart';
import 'package:qr/main.dart';
import 'package:vibration/vibration.dart';

class Option extends StatefulWidget {

  String title;
  Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

  okut() async
  {
    id = await storage.read(key: "id");
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    okut();
  }

  String qr = "";
  String? id = "";
  dynamic response;
  dynamic position;
  bool loading = false;

  success() async
  {
    Vibration.vibrate(duration: 500);
    await Sheet.show(
      [
        const Text("İŞLEM BAŞARILI",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
        SvgPicture.asset("lib/Assets/Images/succes.svg"),
        Text("İşleminiz başarıyla gönderilmiştir.\nİşlem tarihiniz ${dateToDartTrans(DateTime.now())}",style: const TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
        ElevatedButton(onPressed: (){Navigator.pop(context);Navigator.pop(context);}, child: const Text("Ana Sayfa"))
      ]
    );
    setState(() {
      loading = false;
    });
  }

  err() async
  {
    Vibration.vibrate(duration: 1000);
    await Sheet.show(
        [
          const Text("İŞLEM BAŞARISIZ",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
          SvgPicture.asset("lib/Assets/Images/err.svg",width: 75,),
          const Text("Cihaz belirlenen konumun dışındadır!\nLütfen QR kod ekranı deneyin",style: TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
          ElevatedButton(onPressed: (){Navigator.pop(context);okut();}, child: const Text("Başla"))
        ]
    );
    setState(() {
      loading = false;
    });
  }

  cikisqr() async
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

  girisqr() async
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

  cikiskonum() async
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

  giriskonum() async
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar(widget.title),
      body: Center(
        child: loading ? const CircularProgressIndicator() :
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("lib/Assets/Images/logo.svg",width: 90,),
              Container(
                height: MediaQuery.sizeOf(context).height/2,
                decoration: const BoxDecoration(
                  color: Themes.light,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 25,
                        offset: Offset(1, 1),
                      ),
                    ]
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 8,
                      margin: const EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20,),
                          if(widget.title == "Konumlu Uzaktan")
                            const Text("QR kod okutmadan uzaktan, mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Themes.grey),),
                          if(widget.title == "QR Okutmalı")
                            const Text("QR kod ile mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Themes.grey),),
                          const SizedBox(height: 35,),
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
                            child: const Text("Giriş Yap"),
                          ),
                          const SizedBox(height: 25,),
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
                            child: const Text("Çıkış Yap"),
                          ),
                          const SizedBox(height: 25,)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
