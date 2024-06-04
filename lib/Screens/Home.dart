import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Option.dart';
import 'package:qr/Screens/ProcessHistory.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    al();
  }

  dynamic response;
  String? id = "";
  bool loading = true;
  List<String> gunler = [];
  List<Color> renkler = [];

  al() async
  {
    setState(() {
      loading = true;
    });
    gunler = [];
    renkler = [];
    DateTime bugun = DateTime.now();
    DateTime pazartesi = bugun.subtract(Duration(days: bugun.weekday - 1));
    for (int i = 0; i < 7; i++)
    {
      DateTime gun = pazartesi.add(Duration(days: i));
      gunler.add(gun.day.toString());
      renkler.add(Themes.red);
    }
    id = await storage.read(key: "id");
    response = await Network("logs?user_id=$id&key=$key").get();
    for (var value in response) {
      String gunValue = DateFormat('d').format(DateTime.parse(value["updated_at"])).toString();

      if (gunler.contains(gunValue)) {
        int index = gunler.indexOf(gunValue);
        if (value["action"] == "1") {
          renkler[index] = Themes.green;
        } else if (value["action"] == "0") {
          renkler[index] = Themes.orange;
        } else {
          renkler[index] = Themes.red;
        }
      }
    }
    setState(() {
      loading = false;
    });
  }

  Container con(String title, String resim)
  {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, resim=="Standing" ? 15 : 0, 15),
      padding: const EdgeInsets.all(10),
      decoration: Themes.decor,
      width: 300,
      child: InkWell(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Option(title: title)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    const Text("Mesai Hareketi İşle",style: TextStyle(fontSize: 14),),
                  ],
                ),
                Container(
                  width: 65,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Themes.mainColor
                  ),
                  child: const Center(child: Text("Başla",style: TextStyle(color: Themes.light),)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              SvgPicture.asset("lib/Assets/Images/location.svg",width: 75,),
              SvgPicture.asset("lib/Assets/Images/$resim.svg",width: 100,),
              ],),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Text ex(String text)
    {
      return Text(
        text,
        style: const TextStyle(
          color: Themes.grey,
          fontSize: 10,
        ),
        textAlign: TextAlign.start,
      );
    }

    Column ex2(String text,Color color,bool izin)
    {
      String bugun = (DateFormat("dd").format((DateTime.parse(DateTime.now().toString())))).toString();
      bugun = bugun.startsWith("0") ? bugun.replaceAll("0","") : bugun;
      return Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: text == bugun ? Themes.mainColor : Themes.transparent,
                borderRadius: BorderRadius.circular(50)
            ),
            alignment: Alignment.center,
            child: Text(
                text,
                style: TextStyle(
                    color: text == bugun ? Themes.light : color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center
            ),
          ),
          CircleAvatar(radius: 3,backgroundColor: izin ? Themes.mainColor : Themes.transparent,)
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 350,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                con("Konumlu Uzaktan","Sitting"),
                con("QR Okutmalı","Standing"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("İŞLEM GEÇMİŞİ",style: TextStyle(color: Themes.grey),),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProcessHistory()));
                        },
                        child: const Text("TÜMÜNÜ GÖR",style: TextStyle(color: Themes.grey),)
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  decoration: Themes.decor,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bugün ${DateFormat("dd.MM.yyyy").format((DateTime.now()))}",style: const TextStyle(fontSize: 15),),
                          const SizedBox(height: 15,),
                          SvgPicture.asset("lib/Assets/Images/cizgi.svg",width: 150,),
                          const SizedBox(height: 15,),
                          SvgPicture.asset("lib/Assets/Images/segment.svg",width: 115,),
                        ],
                      ),
                      SvgPicture.asset("lib/Assets/Images/person.svg"),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: Themes.decor,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  padding: const EdgeInsets.all(20),
                  child: loading ? const CircularProgressIndicator() : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${monthStr(DateTime.now())} ${DateTime.now().year}",style: const TextStyle(fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ex("PZT"),
                            ex("SAL"),
                            ex("ÇRŞ"),
                            ex("PER"),
                            ex("CUM"),
                            ex("CMT"),
                            ex("PAZ"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ex2(gunler[0],renkler[0],false),
                            ex2(gunler[1],renkler[1],false),
                            ex2(gunler[2],renkler[2],false),
                            ex2(gunler[3],renkler[3],false),
                            ex2(gunler[4],renkler[4],false),
                            ex2(gunler[5],Themes.dark,true),
                            ex2(gunler[6],Themes.dark,true),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.lightGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Mesai Saatleri",style: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold,fontSize: 13),),
                            SvgPicture.asset("lib/Assets/Images/segment.svg",width: 95,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
