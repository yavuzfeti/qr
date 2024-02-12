import 'package:permission_handler/permission_handler.dart';
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

  static Future<bool> control(Permission permisson) async
  {
    PermissionStatus status = await permisson.status;
    if (status.isGranted)
    {
      return true;
    }
    else if (status.isDenied)
    {
      return await request(permisson);
    }
    else if (status.isPermanentlyDenied)
    {
      return await request(permisson);
    }
    return await request(permisson);
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
      openAppSettings();
      return false;
    }
    return false;
  }
}