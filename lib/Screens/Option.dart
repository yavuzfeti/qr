import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/QrScanner.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';
import 'package:vibration/vibration.dart';

class Option extends StatefulWidget {

  final String title;
  const Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

  okut() async
  {
    Message.show("Konumunuz kontrol ediliyor...");
    id = await storage.read(key: "id");
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition();
    setState((){bottomH=true;});
  }

  @override
  void initState() {
    super.initState();
    okut();
  }

  bool bottomH = false;

  String qr = "";
  String? id = "";
  dynamic response;
  dynamic position;
  bool loading = false;

  success(dynamic s) async
  {
    Vibration.vibrate(duration: 500);
    await Sheet.show(
      [
        const Text("İŞLEM BAŞARILI",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
        SvgPicture.asset("lib/Assets/Images/succes.svg"),
        Text("İşleminiz başarıyla gönderilmiştir.\nİşlem tarihiniz ${dateToDartTrans(DateTime.now())}",style: const TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
        //Text(s.toString(),style: const TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
        ElevatedButton(onPressed: (){Navigator.pop(navKey.currentState!.context);}, child: const Text("Ana Sayfa"))
      ]
    );
    setState(() {
      loading = false;
    });
  }

  err(dynamic e) async
  {
    Vibration.vibrate(duration: 1000);
    await Sheet.show(
        [
          const Text("İŞLEM BAŞARISIZ",style: TextStyle(color: Themes.dark,fontSize: 17,fontWeight: FontWeight.bold),),
          SvgPicture.asset("lib/Assets/Images/err.svg",width: 75,),
          const Text("Cihaz belirlenen konumun dışındadır!\nLütfen QR kod ekranı deneyin",style: TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
          //Text(e.toString(),style: const TextStyle(color: Themes.dark,fontSize: 12),textAlign: TextAlign.center,),
          ElevatedButton(onPressed: (){Navigator.pop(navKey.currentState!.context);}, child: const Text("Başla"))
        ]
    );
    setState(() {
      loading = false;
    });
  }
  
  save(String? token,int action) async
  {
    dynamic r = await Network("logs?user_id=$id&token=$token&key=$key&action=$action").post("");
    if (r["status"].toString()!="200")
    {
      throw Exception(r.toString());
    }
  }
  
  control(String t) async
  {
    dynamic r = await Network("locations-user?user_id=$id&company_token=$t&key=$key&coordinates=${position.latitude},${position.longitude}").get();
    if (r["status"].toString()=="200")
    {
      return r;
    }
    else
    {
      throw Exception(r.toString());
    }
  }

  qrProcess(int action) async
  {
      try
      {
        qr = (await Navigator.push(
          navKey.currentState!.context,
          MaterialPageRoute(builder: (context) => const QrScanner()),
        )).substring(7);
        response = await control(qr);
        await save(qr,action);
        success(response);
      }
      catch (e)
      {
        err(e);
      }
  }

  locationProcess(int action) async
  {
      try {
        String? token = await storage.read(key: "company_token");
        response = await control(token??"");
        await save(token,action);
        success(response);
      }catch (e)
      {
        err(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Themes.transparent,
        elevation: 0,
        highlightElevation: 0,
        child: SvgPicture.asset('lib/Assets/Icons/close.svg',color: Themes.dark),
        onPressed: (){Navigator.pop(navKey.currentState!.context);},
      ),
      body: Center(
        child: loading ? const CircularProgressIndicator() :
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("lib/Assets/Images/logo.svg",width: 90,),
              AnimatedContainer(
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 500),
                height: bottomH ? (MediaQuery.sizeOf(context).height-100)/2 : 0,
                decoration: BoxDecoration(
                  color: Themes.light,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                    boxShadow: Themes.shadow,
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    height: (MediaQuery.sizeOf(context).height-100)/2,
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              setState(() {
                                loading = true;
                              });
                              locationProcess(1);
                            }
                            else if(widget.title == "QR Okutmalı")
                            {
                              setState(() {
                                loading = true;
                              });
                              qrProcess(1);
                            }
                          },
                          child: const Text("Giriş Yap"),
                        ),
                        const SizedBox(height: 15,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Themes.dark
                          ),
                          onPressed:()
                          {
                            if(widget.title == "Konumlu Uzaktan")
                            {
                              setState(() {
                                loading = true;
                              });
                              locationProcess(0);
                            }
                            else if(widget.title == "QR Okutmalı")
                            {
                              setState(() {
                                loading = true;
                              });
                              qrProcess(0);
                            }
                          },
                          child: const Text("Çıkış Yap"),
                        ),
                        const SizedBox(height: 25,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
