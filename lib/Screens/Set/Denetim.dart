import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Permissions.dart';

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
    await Permissions.cameraRequest();
    await Permissions.notificationRequest();
    await Permissions.locationRequest();
    setState(() {
      loading = false;
    });
  }

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
              onChanged: (v)
              {
                setState(() {
                  if(!Permissions.camera)
                  {
                    Permissions.cameraRequest();
                  }
                  else
                  {
                    Permissions.camera = !Permissions.camera;
                  }
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
              onChanged: (v)
              {
                setState(() {
                  if(!Permissions.notification)
                  {
                    Permissions.notificationRequest();
                  }
                  else
                  {
                    Permissions.notification = !Permissions.notification;
                  }
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
              onChanged: (v)
              {
                setState(() {
                  if(!Permissions.location)
                  {
                    Permissions.locationRequest();
                  }
                  else
                  {
                    Permissions.location = !Permissions.location;
                  }
                });
              },
            ),
          ),
          con("Mevzuat Bilgilendirmesi", "Gizlilik Politikası", null),
          con("Mevzuat Bilgilendirmesi", "Şartlar ve Koşullar", null),
          con("Sürüm Güncelleme Derlemesi", version, null)
        ],
      ),
    );
  }
}
