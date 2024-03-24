import 'package:flutter/material.dart';
import 'package:qr/Components/TopBar.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopBar("Yardım ve Destek"),
      body: Column(
        children: [
          Text("Soru ve önerileriniz için"),
        ],
      ),
    );
  }
}



