import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Launch
{
  map(String latlong) async => Platform.isIOS ? await launchUrlString("https://maps.apple.com/?q=$latlong") : await launchUrlString("https://www.google.com/maps?q=$latlong");

  whatsapp(String number) async => await launchUrlString("https://wa.me/9$number");

  call(String number) async => await launchUrl(Uri(scheme: "tel",path: number));

  mail(String mail) async => await launchUrl(Uri(scheme: "mailto",path: mail));

  web(String url, {bool? i}) async => await launchUrlString(url, mode: i??false ? LaunchMode.inAppWebView : LaunchMode.platformDefault);
}