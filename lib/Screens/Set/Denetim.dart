import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';

class Denetim extends StatefulWidget {
  const Denetim({super.key});

  @override
  State<Denetim> createState() => _DenetimState();
}

class _DenetimState extends State<Denetim> {
  Container con(String text1, String text2, dynamic trailing) {
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
          trailing: trailing),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar("Denetim Merkezi"),
      body: ListView(
        children: [
          con(
            "Kamera erişimine izin veriyorum",
            "Kamera",
            Switch(
              hoverColor: Themes.mainColor,
              value: true,
              onChanged: (v) {},
            ),
          ),
          con(
            "Bildirim göndermesine izin veriyorum",
            "Bildirim",
            Switch(
              hoverColor: Themes.mainColor,
              value: true,
              onChanged: (v) {},
            ),
          ),
          con(
            "Arkaplanda yenilenmesine izin veriyorum",
            "Arkaplan",
            Switch(
              hoverColor: Themes.mainColor,
              value: true,
              onChanged: (v) {},
            ),
          ),
          con("Mevzuat Bilgilendirmesi", "Gizlilik Politikası", null),
          con("Mevzuat Bilgilendirmesi", "Şartlar ve Koşullar", null),
          con("Sürüm Güncelleme Derlemesi", "v1.0.0", null)
        ],
      ),
    );
  }
}
