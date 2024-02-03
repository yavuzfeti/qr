import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Option.dart';
import 'package:intl/intl.dart';
import 'package:qr/Screens/ProcessHistory.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                          Image.asset("lib/Assets/Images/cizgi.png",width: 125,),
                          SizedBox(height: 10,),
                          SvgPicture.asset("lib/Assets/Images/segment.svg",width: 100,),
                        ],
                      ),
                      SvgPicture.asset("lib/Assets/Images/person.svg"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: SvgPicture.asset("lib/Assets/Images/takvim.svg"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
