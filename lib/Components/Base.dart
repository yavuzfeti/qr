import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/BottomBar.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Components/UpdatePage.dart';
import 'package:qr/Screens/Home.dart';
import 'package:qr/Screens/Notifications.dart';
import 'package:qr/Screens/Settings.dart';
import 'package:qr/Utils/Network.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  List<Widget> body = [
    const Home(),
    const Notifications(),
    const Settings(),
  ];

  @override
  void initState() {
    super.initState();
    run();
  }

  bool update = false;
  String link = "";


  run() async
  {
    if((await storage.read(key: "update")??true)!="false")
    {
      var status = await NewVersionPlus().getVersionStatus();
      if (status != null && status.canUpdate)
      {
        setState(() {
          update = true;
          link = status.appStoreLink;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return Alert.show(title: "Çık", content: const Text(style: TextStyle(color: Themes.dark),"Uygulamadan çıkmak mı istiyorsunuz?"), funLabel: "Çık", fun: (){SystemNavigator.pop();});
      },
      child: update
          ? UpdatePage((){setState(() {update=false;});},link)
          : Scaffold(
        backgroundColor: Themes.back,
        appBar: TopBar("home"),
        body:IndexedStack(
          index: bottomIndex,
          children: body,
        ),
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