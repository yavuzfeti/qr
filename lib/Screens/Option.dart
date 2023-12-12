import 'package:flutter/material.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';

class Option extends StatefulWidget {

  String title;
  Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

  okut() async
  {
    await Sheet.show(
        [
          Text("QR kod okutmadan uzaktan, mesai hareketi işleyebilirsin",textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
          ElevatedButton(
            onPressed: (){}, child: Text("Giriş Yap"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.dark
            ),
            onPressed: (){}, child: Text("Çıkış Yap"),
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 250),okut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar(widget.title),
      body: Center()
    );
  }
}
