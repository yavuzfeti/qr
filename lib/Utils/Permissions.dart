import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/Message.dart';

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
      await Message.show("İzin kalıcı olarak reddedildi, ayarlara yönlendiriliyorsunuz");
      return false;
    }
    return false;
  }
  
  static alert(Permission permission) async
  {
    if(permission==Permission.camera)
    {
      await Alert.show(content: const Text("QR kodu okutmak için kamera izni vermeniz gerekiyor."));
    }
    else if(permission==Permission.notification)
    {
      await Alert.show(content: const Text("Bildirim gösterebilmemiz için bildirimlere izin vermeniz gerekiyor."));
    }
    else if(permission==Permission.location)
    {
      await Alert.show(content: const Text("Konumunuzu kullanarak giriş yapabilmeniz için konum izni vermeniz gerekiyor."));
    }
  }
}