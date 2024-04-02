import 'package:flutter/material.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Navigation.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';

class ChangeUser extends StatefulWidget {

  final String item;

  ChangeUser(this.item);

  @override
  State<ChangeUser> createState() => _ChangeUserState();
}

class _ChangeUserState extends State<ChangeUser> {

  @override
  void initState() {
    super.initState();
    run();
  }

  String title = "";
  TextEditingController ad = TextEditingController();
  TextEditingController soyad = TextEditingController();
  TextEditingController numara = TextEditingController();
  TextEditingController eposta = TextEditingController();
  TextEditingController sifre = TextEditingController();
  TextEditingController sifre2 = TextEditingController();

  double pswValue = 0;

  List<Widget> items=[];

  bool visible = true;

  bool ok = false;

  changePassword(StateSetter setter) async
  {
    if(sifre.text.isNotEmpty&&sifre2.text.isNotEmpty&&sifre.text == sifre2.text)
    {
      setState(() {
        ok=true;
      });
    }
    else
    {
      setState(() {
        ok=false;
      });
    }
    setter(() {
      pswValue=(sifre.text.length<sifre2.text.length ? sifre2.text.length : sifre.text.length)*0.17;
    });
  }

  edittext(TextEditingController controller,String uptext,{String? subtext,bool? psw,VoidCallback? fun}) =>
      StatefulBuilder(
        builder: (context,setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(uptext,style: const TextStyle(color: Themes.grey,fontSize: 12),),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (v)
                {
                  if(fun!=null)
                  {
                    fun();
                  }
                },
                keyboardType: psw!=null ? TextInputType.number : null,
                obscureText: psw!=null ? visible : false,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: uptext,
              suffixIcon: psw!=null ? IconButton(
                iconSize: 20,
                onPressed: (){
                  setState(() {
                    visible=!visible;
                  });
                },
                  icon: Icon(visible ? Icons.visibility_outlined : Icons.visibility_off_outlined))
                    :null,
              hintStyle: const TextStyle(color: Themes.lightGrey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Themes.lightGrey,
                      width: 2
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Themes.mainColor,
                      width: 2
                  )
              ),
                  ),
                ),
              const SizedBox(height: 25),
              if(subtext!=null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(subtext,style: const TextStyle(color: Themes.grey,fontSize: 11),),
                ),
            ],
          );
        }
      );

  run() async
  {
    if(widget.item=="password")
    {
      items.add(
          StatefulBuilder(
              builder: (context,setState) {
            return Column(
              children: [
                edittext(sifre,'Yeni şifre',psw: true,fun: (){changePassword(setState);}),
                edittext(sifre2,'Yeni şifre tekrar',psw: true,subtext: 'Şifre gücü',fun: (){changePassword(setState);}),
                Container(
                  height: 125,
                  padding: const EdgeInsets.only(left: 15,top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: Themes.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: pswValue,
                        color: pswValue>1 ? Themes.green : Themes.mainColor,
                      ),
                      const Text("Şifre şunlar içermelidir",style: TextStyle(fontWeight: FontWeight.bold),),
                      const Text("x En az altı rakam (0-9)",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            );
          }
        )
      );
      setState(() {
        title = "Şifre";
      });
    }
    else if(widget.item=="name")
    {
      items.add(edittext(ad,'Adınız'));
      items.add(edittext(soyad,'Soyadınız',subtext: 'Lütfen Türkiye Cumhuriyeti kimlik kartınızda yazan adınızı ve soyadınızı yazın'));
      setState(() {
        title = "Ad Soyad";
      });
    }
    else if(widget.item=="phone")
    {
      items.add(edittext(numara,'Telefon numaranız',subtext: 'Telefon numaranızı değiştirirseniz, yetkili tarafından onay sürecine gönderilecektir.'));
      setState(() {
        title = "Telefon";
      });
    }
    else if(widget.item=="mail")
    {
      items.add(edittext(eposta,'E-posta',subtext: 'Lütfen kurumsal e-posta adresinizi kullanınız'));
      setState(() {
        title = "E-posta";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title),
      floatingActionButton: ok ? Container(
        height: 40,
        decoration: BoxDecoration(
            color: Themes.light,
            border: Border(
              top:BorderSide(
                color: Themes.grey.withOpacity(0.2),
                width: 1,
              ),
            )
        ),
        width: MediaQuery.sizeOf(context).width-25,
        child: FloatingActionButton(
          backgroundColor: Themes.light,
          elevation: 0,
          onPressed: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed:() async
                  {
                    try {
                      String mail = await storage.read(key: "email") ?? "";
                      dynamic response = await Network("auth/password-change?email=$mail&key=$key").get();
                      await Network("auth/password-change?token=${response["token"]}&newPassword=${sifre.text}").post({});
                      Navigation().back();
                    } catch (e) {
                      Message.show("Hata oluştu her şifre değiştirme işlemi arasında en az 1 saat olmalıdır.");
                      throw Exception(e);
                    }
                  },
                  child: const Text("Bitti")
              )
            ],
          ),
        ),
      ) : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        ),
      ),
    );
  }
}