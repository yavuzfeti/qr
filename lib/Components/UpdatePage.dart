import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {

  final VoidCallback update;
  final String link;

  const UpdatePage(this.update, this.link, {super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: SvgPicture.asset("lib/Assets/Images/upload.svg",height: MediaQuery.sizeOf(context).height-350,)
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: ()
                  {
                    launch(widget.link);
                  },
                  child: const Text("Güncelle")
              ),
            ),
            TextButton(
                onPressed: ()
                {
                  widget.update.call();
                },
                child: const Text("DAHA SONRA HATIRLAT",style: TextStyle(color: Themes.grey),)
            ),
          ],
        ),
      ),
    );
  }
}