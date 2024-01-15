import 'package:flutter/material.dart';
import 'package:qr/Components/Alert.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Sheet.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Screens/Login.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';

class Hesap extends StatefulWidget {
  const Hesap({super.key});

  @override
  State<Hesap> createState() => _HesapState();
}

class _HesapState extends State<Hesap> {

  @override
  void initState() {
    super.initState();
    al();
  }

  String? adSoyad;
  String? mail;
  String? sifre;
  String? telefon;
  String? id;

  bool loading = true;

  al() async
  {
    setState(() {
      loading = true;
    });
    adSoyad = "${await storage.read(key: "name")} ${await storage.read(key: "surname")}";
    mail = await storage.read(key: "email") ?? "";
    telefon = "${await storage.read(key: "username")}";
    id = "${await storage.read(key: "id")}";
    sifre = "*" * (await storage.read(key: "password") ?? "***").length;
    setState(() {
      loading = false;
    });
  }

  Container con(String text1, String text2, Widget? oge) {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: Themes.decor,
      child: ListTile(
          title: Text(
                text1,
                style: TextStyle(color: Themes.text, fontSize: 12),
          ),
          subtitle: oge != null ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text2,
                style: TextStyle(
                    color: Themes.text, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              oge
            ],
          )
              : Text(
            text2,
            style: TextStyle(
                color: Themes.text, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit_rounded),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.lightGrey,
      appBar: TopBar("Hesap Kimliği ayarları"),
      body: loading
          ? Center(child: CircularProgressIndicator(),)
          : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                con("Adınız Soyadınız", adSoyad!, null),
                con("E-Posta", mail!,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(75, 35),
                      ),
                      onPressed: () async
                      {
                        await Network("email-verification").post({
                          "user_id": id,
                          "key": key
                        });
                        Message.show("Doğrulama epostası iletildi.");
                      },
                      child: Text("E-Posta Adresini Doğrula")
                  ),
                ),
                con("Şifre", sifre!, null),
                con("Cep Telefonu", telefon!, null),
                TextButton(
                    onPressed: () async
                    {
                      await Sheet.show(
                          [
                            Text("Hesabınızı silmek istediğinizden emin misiniz?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
                            Text("Bu kalıcı bir işlemdir ve anında hesabınızdan çıkış yapılır. Aydınlatma Metni ve Gizlilik Politikası kuralları saklıdır.",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                            ElevatedButton(
                              onPressed: (){},
                              child: Text("EVET, EMİNİM"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Themes.red
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (){},
                              child: Text("HAYIR, HESABIMI SİLME"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Themes.dark
                              ),
                            ),
                          ]
                      );
                    },
                    child: Text("Hesabımı sil",style: TextStyle(color: Themes.red,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 65),
                backgroundColor: Themes.light,
                foregroundColor: Themes.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () async
            {
              await Alert.show(title: "Çıkış Yap",content: Text("Çıkış yapmak istediğinize emin misiniz?",style: TextStyle(color: Themes.dark),),funLabel: "Çık",fun: ()
              {
                storage.deleteAll();
                Navigator.pushAndRemoveUntil(
                  navKey.currentState!.context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                );
              });
            },
            icon: Icon(Icons.logout_rounded,color: Themes.red,),
            label: Text("Çıkış Yap"),
          ),
        ],
      ),
    );
  }
}
