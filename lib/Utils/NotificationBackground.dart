import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';

class NotificationBackground
{
  static int _index = 0;

  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _android = AndroidNotificationDetails(
      "qr",
      "qr_channel",
      priority: Priority.high,
      importance: Importance.high,
      icon: "@mipmap/ic_launcher",
      color: Themes.secondaryColor,
      //sound: RawResourceAndroidNotificationSound('notification'),
  );

  static const DarwinNotificationDetails _ios = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    //sound: 'notification.aac',
  );

  static const NotificationDetails _notDet = NotificationDetails(android: _android, iOS: _ios);

  static _send({required String title, required String body}) async
  {
    _index ++;
    await notifications.show(
        _index,
        title,
        body,
        _notDet
    );
  }

  static start() async
  {
    await initialize();
    print(await firebaseMessaging.getToken());
    await listen();
    await listenClick();
  }

  static initialize() async
  {
    await firebaseMessaging.setAutoInitEnabled(true);
    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );
    firebaseMessaging.subscribeToTopic("all");
  }

  static add(String topic) async
  {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  static _process(RemoteMessage message) async
  {
    String title = message.notification?.title ?? "";
    String body = message.notification?.body ?? "";
    _send(title: title, body: body);
    view(title,body);
  }

  static listen() async => FirebaseMessaging.onMessage.listen((RemoteMessage message) async => await _process(message));

  static listenClick() async => FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async => await _process(message));

  static view(String title, String text) async => Alert.show(title: title,content: Text(text,style: const TextStyle(color: Themes.light),));
}