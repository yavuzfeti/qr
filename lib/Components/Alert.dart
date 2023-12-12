import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Alert {
  static show({
    String? title,
    required dynamic content,
    String? funLabel,
    dynamic fun,
    bool? barrier,
  }) async {
    await showDialog(
      context: navKey.currentState!.context,
      barrierDismissible: barrier ?? true,
      builder: (alertContext) => WillPopScope(
        onWillPop: () async => barrier ?? true,
        child: AlertDialog(
          backgroundColor: Themes.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: title != null
              ? Text(
            title,
            style: const TextStyle(color: Themes.dark),
          )
              : null,
          content: content,
          actions: (funLabel==null && barrier == false) ? null : [
            if(barrier ?? true)
              TextButton(
                onPressed: () {
                  Navigator.of(alertContext).pop();
                },
                child: const Text(style: TextStyle(color: Themes.dark), "Geri"),
              ),
            if(funLabel!=null)
              TextButton(
                onPressed: () {
                  fun();
                },
                child: Text(
                    style: const TextStyle(color: Themes.secondaryColor), funLabel),
              ),
          ],
        ),
      ),
    );
  }
}