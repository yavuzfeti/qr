import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Alert {
  static show({
    String? title,
    required dynamic content,
    String? funLabel,
    dynamic fun,
    String? backLabel,
    dynamic backFun,
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
          actions: [
            if(!(barrier ?? true))
              TextButton(
                onPressed: ()
                {
                  if(backLabel!=null){backFun();}
                  else{Navigator.of(alertContext).pop();}
                },
                child: Text(backLabel!=null ? backLabel : "Geri",style: TextStyle(color: Themes.dark)),
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