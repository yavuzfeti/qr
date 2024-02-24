import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class Denetim extends StatefulWidget {
  const Denetim({super.key});

  @override
  State<Denetim> createState() => _DenetimState();
}

class _DenetimState extends State<Denetim> {

  @override
  void initState() {
    super.initState();
    run();
  }

  String version = "";

  bool loading = true;

  run() async
  {
    setState(() {
      loading = true;
    });
    var status = await PackageInfo.fromPlatform();
    setState(() {
      version = status.version;
    });
    Permissions.notification = await Permissions.onlyControl(Permission.notification);
    Permissions.camera = await Permissions.onlyControl(Permission.camera);
    Permissions.location = await Permissions.onlyControl(Permission.location);
    setState(() {
      Permissions.camera;
      Permissions.notification;
      Permissions.location;
      loading = false;
    });
  }

  InkWell con(String text1, String text2, dynamic trailing, {bool? l}) {
    return InkWell(
      onTap: ()
      {
        if(l??false)
        {
          launch("https://qr-pdks.notion.site/qr-pdks/Yasak-Metinler-eb48374824294054afc5f5e8dd2c8ea3");
        }
      },
      child: Container(
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar("Denetim Merkezi"),
      body: loading
        ? Center(child: CircularProgressIndicator(),)
          : ListView(
        children: [
          con(
            "Kamera erişimine izin veriyorum",
            "Kamera",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.camera,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.camera))
                {
                Permissions.cameraRequest();
                }
                else
                {
                Permissions.camera = !Permissions.camera;
                }
                setState(() {
                });
              },
            ),
          ),
          con(
            "Bildirim göndermesine izin veriyorum",
            "Bildirim",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.notification,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.notification))
                {
                Permissions.notificationRequest();
                }
                else
                {
                Permissions.notification = !Permissions.notification;
                }
                setState(() {
                });
              },
            ),
          ),
          con(
            "Arkaplanda yenilenmesine izin veriyorum",
            "Arkaplan",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.location,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.location))
                {
                  Permissions.locationRequest();
                }
                else
                {
                  Permissions.location = !Permissions.location;
                }
                setState(() {
                });
              },
            ),
          ),
          con("Mevzuat Bilgilendirmesi", "Gizlilik Politikası", null,l: true),
          con("Mevzuat Bilgilendirmesi", "Şartlar ve Koşullar", null,l: true),
          con("Sürüm Güncelleme Derlemesi", version, null)
        ],
      ),
    );
  }
}
