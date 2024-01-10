import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';

double topBarHeight = 85;

class TopBar extends StatefulWidget implements PreferredSizeWidget {

  String title;
  TopBar(this.title, {super.key});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(topBarHeight);
}

class _TopBarState extends State<TopBar> {

  @override
  void initState() {
    super.initState();
    al();
  }

  String ad = "";

  al() async
  {
    ad = await storage.read(key: "surname") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.back,
      centerTitle: true,
      toolbarHeight: topBarHeight,
      title: widget.title == "home"
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                      children: [
              Text("Merhaba ",style: const TextStyle(color: Themes.text,fontSize: 22),),
              Text("$ad",style: const TextStyle(color: Themes.text,fontSize: 22),),
              Icon(Icons.front_hand_sharp,color: Colors.black45,size: 32,)
                      ],
                    ),
              Text("QR PDKS’e tekrardan hoş geldin!",style: const TextStyle(color: Themes.text,fontSize: 15),),
            ],
          )
          : Text(widget.title,style: const TextStyle(color: Themes.text,fontWeight: FontWeight.bold),),
      actions: [],
    );
  }
}