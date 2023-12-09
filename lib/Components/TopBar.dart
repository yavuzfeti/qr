import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';

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
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.back,
      centerTitle: true,
      toolbarHeight: topBarHeight,
      title: widget.title == "home"
          ? Row(
        children: [
          Text("Merhaba ",style: const TextStyle(color: Themes.text),),
          Text("Çetin",style: const TextStyle(color: Themes.text),),
          Icon(Icons.front_hand_sharp,color: Themes.mainColor,)
        ],
      )
          : Text(widget.title,style: const TextStyle(color: Themes.text,fontWeight: FontWeight.bold),),
      actions: [],
    );
  }
}