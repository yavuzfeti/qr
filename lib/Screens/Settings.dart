import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Screens/Set/Denetim.dart';
import 'package:qr/Screens/Set/Help.dart';
import 'package:qr/Screens/Set/Hesap.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Container con(String text1, String text2,dynamic route) {
    return Container(
      width: double.infinity,
      height: 108,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: Themes.decorSettings,
      child: ListTile(
          title: Text(
            text2,
            style: TextStyle(
                color: Themes.text, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            text1,
            style: TextStyle(color: Themes.text, fontSize: 12),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_rounded,color: Themes.mainColor,),
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => route));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Themes.light,
      child: ListView(
        children: [
          con("Uygulama izin ve bilgilendirme ayarları", "Denetim Merkezi",Denetim()),
          con("Kişisel bilgilerini güncelleme", "Hesap Kimliği Ayarları",Hesap()),
          con("Destek Hizmetleri", "Yardım ve Destek",Help()),
          con("QR PDKS uygulaması hakkında", "Uygulama Hakkında",Help())
        ],
      ),
    );
  }
}