import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Option.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Container con(String title, String resim)
  {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: Themes.decor,
      width: 250,
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
              Image.asset("lib/Assets/Images/konum.png",width: 75,),
              Image.asset("lib/Assets/Images/$resim.png",width: 100,),
              ],),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  con("Konumlu Uzaktan","Sitting"),
                  con("QR Okutmalı","Standing"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("İŞLEM GEÇMİŞİ"),
                TextButton(onPressed: (){},
                    child: Text("Tümünü Gör")
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
                  Image.asset("lib/Assets/Images/segment.png",width: 100,),
                ],
              ),
              Image.asset("lib/Assets/Images/person.png",width: 125,),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}
