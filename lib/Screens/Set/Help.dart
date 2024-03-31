import 'package:flutter/material.dart';
import 'package:qr/Components/Launch.dart';
import 'package:qr/Components/Navigation.dart';
import 'package:qr/Components/Svg.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Screens/Set/Answer.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  
  con(String text, String icon,VoidCallback fun)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Themes.mainColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: Themes.light,
          ),
        ),
        trailing: IconSvg(icon,color: Themes.light,),
        onTap: ()
        {
          fun();
        },
      ),
    );
  }

  con2(String text,String answer,{double? size})
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      width: double.infinity,
      height: size ?? 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Themes.lightGrey,
          borderRadius: BorderRadius.circular(15),
        boxShadow: Themes.shadow
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: Themes.dark,
          ),
        ),
        trailing: Icon(Icons.add_rounded,color: Themes.dark,),
        onTap: ()
        {
          Navigation().go(Answer(text,answer));
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopBar("Yardım ve Destek"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Soru ve Öneriler için",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ],
                ),
              ),
              con("info@qrpdks.com","info",(){Launch().mail("info@qrpdks.com");}),
              con("0850 307 77 19","call",(){Launch().call("08503077719");}),
              con("Whatsapp Destek","wp",(){Launch().whatsapp("8503077719");}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Sıkça Sorulan Sorular",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ],
                ),
              ),
              con2(
                  "QR PDKS nedir?",
                  "QR PDKS, Personel Takip ve Devam Sistemi'nin (PDKS) gelişmiş bir versiyonudur, personelin giriş ve çıkışlarını QR kodlarıyla takip eder."
              ),
              con2(
                  "QR PDKS nasıl çalışır?",
                  "QR PDKS, personelin giriş ve çıkışlarını QR kodlarıyla tarayarak ya da iş yerini konumunuzu kullanarak hızlı ve doğru bir şekilde kaydeder."
              ),
              con2(
                  "Giriş ve çıkışlarını nasıl kaydedeceğim?",
                  "QR PDKS ile, işe giriş ve çıkışlarınızı QR kodlarını tarayarak kolayca kaydedebilirsiniz."
              ),
              con2(
                  "QR PDKS'nin benim işimi nasıl kolaylaştıracağını anlayabilir miyim?",
                  "QR PDKS ile, işe giriş ve çıkışlarınızı QR kodlarını tarayarak kolayca kaydedebilirsiniz."
              ),
              con2(
                  "Personel bilgilerim güvende mi?",
                  "Evet, QR PDKS güvenlik standartlarına uygun olarak tasarlanmıştır ve personel bilgileri şifrelenmiş olarak saklanır."
              ),
              con2(
                  "Giriş çıkış saatlerimde herhangi bir değişiklik olursa nasıl bildirim alabilirim?",
                  "Evet, QR PDKS güvenlik standartlarına uygun olarak tasarlanmıştır ve personel bilgileri şifrelenmiş olarak saklanır.",
                  size: 85
              ),
            ],
          ),
        ),
      ),
    );
  }
}



