import 'package:flutter/material.dart';
import 'package:qr/Components/BottomBar.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {

  String title;
  TopBar(this.title, {super.key});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(125);
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
    ad = await storage.read(key: "name") ?? "";
    setState(() {
      ad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Themes.back,
          height: 55,
        ),
        if(widget.title!="home"||bottomIndex!=0)
          Container(
            width: MediaQuery.sizeOf(context).width-25,
            height: 13,
            decoration: BoxDecoration(
              color: widget.title == "İşlem Geçmişi" ? Themes.green : Themes.mainColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
        Expanded(
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leadingWidth: 40,
            backgroundColor: widget.title == "home" && bottomIndex == 0 ? Themes.back : Colors.white,
            centerTitle: true,
            title: widget.title == "home"
                ? bottomIndex == 1
                ? const Text("Bildirimler",style: TextStyle(color: Themes.text,fontWeight: FontWeight.bold),)
                : bottomIndex == 2
                ? const Text("Ayarlar",style: TextStyle(color: Themes.text,fontWeight: FontWeight.bold),)
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    const Text("Merhaba ",style: TextStyle(color: Themes.text,fontSize: 22),),
                    Text(ad,style: const TextStyle(color: Themes.text,fontSize: 22,fontWeight: FontWeight.bold),),
                        const SizedBox(width: 5,),
                        Image.asset("lib/Assets/Icons/hand.png")
                            ],
                          ),
                    const Text("QR PDKS’e tekrardan hoş geldin!",style: TextStyle(color: Themes.text,fontSize: 15),),
                  ],
                )
                : Text(widget.title,style: const TextStyle(color: Themes.text,fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    );
  }
}