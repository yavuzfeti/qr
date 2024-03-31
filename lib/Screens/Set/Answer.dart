import 'package:flutter/material.dart';
import 'package:qr/Components/Svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';

class Answer extends StatefulWidget {

  final String question;
  final String text;

  Answer(this.question, this.text);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {

  con(String text,{double? size})
  {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Themes.lightGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: Themes.shadow
      ),
      child: Text(
          text,
          style: TextStyle(
            color: Themes.dark,
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopBar("Soru - Cevap"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal:20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconSvg("sohbet",size: 45,),
              SizedBox(height: 25,),
              con(widget.question),
              con(widget.text),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("İçerik yardımcı oldu mu?",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){},
                            icon: IconSvg("like")
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: IconSvg("dontlike")
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



