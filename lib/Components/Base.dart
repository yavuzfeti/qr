import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/BottomBar.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Screens/Home.dart';
import 'package:qr/Screens/Notifications.dart';
import 'package:qr/Screens/Settings.dart';

class Base extends StatefulWidget
{
  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  List<Widget> body = [
    Home(),
    Notifications(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return Alert.show(title: "Çık", content: const Text(style: TextStyle(color: Themes.dark),"Uygulamadan çıkmak mı istiyorsunuz?"), funLabel: "Çık", fun: (){SystemNavigator.pop();});
      },
      child: Scaffold(
        backgroundColor: Themes.back,
        appBar: TopBar("home"),
        body: body[bottomIndex],
        bottomNavigationBar: BottomBar(items: [
          GButton(
            leading: SvgPicture.asset("lib/Assets/Icons/home.svg",color: bottomIndex == 0 ? Themes.dark : Themes.grey,width: 25,height: 25,),
            text: "Anasayfa",
            icon: Icons.add,
          ),
          GButton(
            leading: SvgPicture.asset("lib/Assets/Icons/not1.svg",color: bottomIndex == 1 ? null : Themes.grey,width: 25,height: 25,),
            text: "Bildirimler",
            icon: Icons.add,
          ),
          GButton(
            leading: SvgPicture.asset("lib/Assets/Icons/user.svg",color: bottomIndex == 2 ? Themes.dark : Themes.grey,width: 25,height: 25,),
            text: "Ayarlar",
            icon: Icons.add,
          ),
        ],update:(){setState((){bottomIndex;});},),
      ),
    );
  }
}