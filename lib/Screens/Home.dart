import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Option.dart';
import 'package:intl/intl.dart';
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
        if (value["action"] == "0") {
          renkler[index] = Themes.mainColor;
        } else if (value["action"] == "1") {
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
      padding: EdgeInsets.all(10),
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
                    Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Text("Mesai Hareketi İşle",style: TextStyle(fontSize: 14),),
                  ],
                ),
                Container(
                  width: 65,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Themes.secondaryColor
                  ),
                  child: Center(child: Text("Başla",style: TextStyle(color: Themes.light),)),
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

    Expanded ex(String text)
    {
      return Expanded(
        flex: 1,
          child: Text(
            text,
            style: TextStyle(
              color: Themes.grey,
              fontSize: 10,
            ),
            textAlign: TextAlign.start,
          )
      );
    }

    Expanded ex2(String text,Color color)
    {
      return Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start
            ),
          )
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("İŞLEM GEÇMİŞİ",style: TextStyle(color: Themes.grey),),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProcessHistory()));
                        },
                        child: Text("TÜMÜNÜ GÖR",style: TextStyle(color: Themes.grey),)
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                          Text("Bugün ${DateFormat("dd.MM.yyyy").format((DateTime.now()))}",style: TextStyle(fontSize: 15),),
                          SvgPicture.asset("lib/Assets/Images/cizgi.svg",width: 125,),
                          SizedBox(height: 10,),
                          SvgPicture.asset("lib/Assets/Images/segment.svg",width: 100,),
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
                  padding: EdgeInsets.all(20),
                  child: loading ? CircularProgressIndicator() : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${monthStr(DateTime.now())} ${DateTime.now().year}",style: TextStyle(fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 3),
                        child: Row(
                          children: [
                            ex("PZT"),
                            ex("SAL"),
                            ex("PER"),
                            ex("ÇRŞ"),
                            ex("CUM"),
                            ex("CMT"),
                            ex("PAZ"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 3),
                        child: Row(
                          children: [
                            ex2(gunler[0],renkler[0]),
                            ex2(gunler[1],renkler[1]),
                            ex2(gunler[2],renkler[2]),
                            ex2(gunler[3],renkler[3]),
                            ex2(gunler[4],renkler[4]),
                            ex2(gunler[5],renkler[5]),
                            ex2(gunler[6],Themes.dark),
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
                        child: Text("Mesai Saatleri",style: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold,fontSize: 13),),
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
