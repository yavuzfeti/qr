import 'package:flutter/material.dart';
import 'package:qr/Components/TopBar.dart';

class ContentView extends StatelessWidget {

  final String title;
  final String body;

  const ContentView(this.title, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Text(
              body
            ),
          ),
        ),
      ),
    );
  }
  
}
