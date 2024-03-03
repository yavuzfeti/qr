import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("lib/Assets/Images/notifi.svg",width: 250,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bildirim Geçmişi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("Günlük ${dateToDartTrans(DateTime.now())}")
                    ],
                  ),
                ),
              ],
            ),
        ),
        Expanded(
          child: Container(
            color: Themes.light,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index)
                  {
                    return Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset("lib/Assets/Icons/not2.svg"),
                          title: Text("Ofise gelme vakti yaklaşıyor!",style: TextStyle(fontSize: 14),),
                        ),
                        Container(
                          color: Themes.lightGrey,
                          width: double.infinity,
                          height: 1,
                        )
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }
}
