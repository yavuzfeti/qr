import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Set/Denetim.dart';
import 'package:qr/Screens/Set/Hesap.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Container con(String text1, String text2, dynamic trailing,dynamic route) {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: Themes.decor,
      child: ListTile(
          title: Text(
            text1,
            style: TextStyle(color: Themes.text, fontSize: 12),
          ),
          subtitle: Text(
            text2,
            style: TextStyle(
                color: Themes.text, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => route));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        con("Uygulama İzin Ayarları", "Denetim Merkezi", Icon(Icons.keyboard_arrow_right_rounded,color: Themes.text,),Denetim()),
        con("Profil Ayarları", "Hesap Kimliği Ayarları", Icon(Icons.keyboard_arrow_right_rounded,color: Themes.text,),Hesap())
      ],
    );
  }
}