import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  bool islem = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.grey,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('QR OKUT',style: TextStyle(color: Themes.light,fontSize: 16),),
            SizedBox(
              width: MediaQuery.sizeOf(context).width-100,
              height: MediaQuery.sizeOf(context).width-100,
              child: MobileScanner(
                overlay: Container(
                    width: MediaQuery.sizeOf(context).width-100,
                    height: MediaQuery.sizeOf(context).width-100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Themes.mainColor,
                      width: 3
                    )
                  ),
                ),
                onDetect: (BarcodeCapture capture)
                {
                  if(!islem)
                  {
                    islem=true;
                    Navigator.pop(navKey.currentState!.context,capture.barcodes[0].displayValue.toString());
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text('QR KODU yukarıdaki alan içerisinde kalacak şekilde tarat.',style: TextStyle(color: Themes.light,fontSize: 14),textAlign: TextAlign.center,),
            ),
            IconButton(onPressed: (){Navigator.pop(navKey.currentState!.context);}, icon:SvgPicture.asset('lib/Assets/Icons/close.svg',color: Themes.light,))
          ],
        ),
      ),
    );
  }
}
