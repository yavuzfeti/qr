import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Sheet
{
  static show(List<Widget> items) async
  {
    showModalBottomSheet(
      isDismissible: false,
      context: navKey.currentState!.context,
      backgroundColor: Themes.transparent,
      builder: (BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Themes.back,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 8,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: items,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}