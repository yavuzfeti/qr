import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/Themes.dart';
import 'package:url_launcher/url_launcher.dart';

class Version
{
  control() async
  {
    var status = await NewVersionPlus().getVersionStatus();
    if (status != null && status.canUpdate)
    {
      Alert.show(
          title: "Güncelleme Mevcut",
          content: Text(status.releaseNotes ?? "Hatalar giderildi ve performans iyileştirmeleri yapıldı.",style: const TextStyle(color: Themes.dark),),
          funLabel: "Güncelle",
          fun: ()
          {
            launch(status.appStoreLink);
          }
      );
    }
  }
}