import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Message
{
  static show(String mesaj,{IconData? icon}) async
  {
    ScaffoldMessenger.of(navKey.currentState!.context).showSnackBar(
      SnackBar(
        elevation: 5,
        duration: const Duration(seconds: 2),
        backgroundColor: Themes.mainColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(style: const TextStyle(color: Themes.light,fontSize: 15),mesaj)),
            const SizedBox(width: 10),
            Icon(icon, color: Themes.light,),
          ],
        ),
      ),
    );
  }
}