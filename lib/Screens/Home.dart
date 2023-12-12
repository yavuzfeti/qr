import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Option.dart';

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
              Image.asset(resim,width: 100,),
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
                  con("Konumlu Uzaktan","lib/Assets/Images/Sitting.png"),
                  con("QR Okutmalı","lib/Assets/Images/Standing.png"),
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
          ],
        ),
      ),
    );
  }
}
