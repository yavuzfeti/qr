import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPage extends StatelessWidget {

  final String icon;
  final String text;
  final String subText;

  const EmptyPage(this.icon, this.text, this.subText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("lib/Assets/Icons/$icon.svg"),
          SizedBox(height: 25,),
          Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(subText),
        ],
      ),
    );
  }
}
