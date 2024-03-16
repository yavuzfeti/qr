import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/main.dart';

class Permissions
{
  static bool location = false;
  static bool notification = false;
  static bool camera = false;

  static Future<void> notificationRequest() async
  {
    notification = await control(Permission.notification);
  }

  static Future<void> cameraRequest() async
  {
    camera = await control(Permission.camera);
  }

  static Future<void> locationRequest() async
  {
    location = await control(Permission.location);
  }

  static Future<bool> control(Permission permission) async
  {
    PermissionStatus status = await permission.status;
    if (status.isGranted)
    {
      return true;
    }
    else if (status.isDenied)
    {
      await alert(permission);
      return await request(permission);
    }
    else if (status.isPermanentlyDenied)
    {
      await alert(permission);
      return await request(permission);
    }
    return await request(permission);
  }

  static Future<bool> onlyControl(Permission permission) async
  {
    PermissionStatus status = await permission.status;
    if (status.isGranted)
    {
      return true;
    }
    else if (status.isDenied)
    {
      return false;
    }
    else if (status.isPermanentlyDenied)
    {
      return false;
    }
    return false;
  }

  static Future<bool> request(Permission permission) async
  {
    PermissionStatus status = await permission.request();
    if (status.isGranted)
    {
      return true;
    }
    else if (status.isDenied)
    {
      Message.show("İzin reddedildi");
      return false;
    }
    else if (status.isPermanentlyDenied)
    {
      await Message.show("İzin kalıcı olarak reddedildi");
      return false;
    }
    return false;
  }
  
  static alert(Permission permission) async
  {
    if(permission==Permission.camera)
    {
      await show("KAMERA ONAYI","QR kodu okutmak için kamera izni vermeniz gerekiyor.");
    }
    else if(permission==Permission.notification)
    {
      await show("BİLDİRİM ONAYI","QR PDKS mesai başlangıcı ve bitişinden önce senin için özel bildirimlerimiz olacak. Seninle daha yakın ve etkili iletişim kurmak için sabırsızlanıyoruz!");
    }
    else if(permission==Permission.location)
    {
      await show("KONUM ONAYI","Konumunuzu kullanarak giriş yapabilmeniz için konum izni vermeniz gerekiyor.");
    }
  }

  static show(String text,String text2) async
  {
    await Sheet.show(
      [
        Text(text,style: const TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        SvgPicture.asset("lib/Assets/Icons/bell.svg"),
        Text(text2,textAlign: TextAlign.center,),
        ElevatedButton(
            onPressed: (){Navigator.pop(navKey.currentState!.context);},
            child: const Text("İZİN VER")
        ),
      ]
    );
  }
}