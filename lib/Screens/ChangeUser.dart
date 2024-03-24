import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';

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

  List<Widget> items=[];

  bool visible = true;

  edittext(TextEditingController controller,String uptext,{String? subtext,bool? psw}) =>
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
      items.add(edittext(sifre,'Yeni şifre',psw: true));
      items.add(edittext(sifre2,'Yeni şifre tekrar',psw: true,subtext: 'Şifre gücü'));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }
}


// {
//   TextEditingController sifreC = TextEditingController();
//   await Alert.show(
//     title: "Yeni şifre",
//       content: TextField(
//         controller: sifreC,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           hintText: "Yeni şifrenizi giriniz",
//           hintStyle: TextStyle(color: Themes.grey),
//         ),
//         inputFormatters:
//         [
//           LengthLimitingTextInputFormatter(6),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//       ),
//     funLabel: "Kaydet",
//     fun: () async
//     {
//       try {
//         String mail = await storage.read(key: "email") ?? "";
//         dynamic response = await Network("auth/password-change?email=$mail&key=$key").get();
//         await Network("auth/password-change?token=${response["token"]}&newPassword=${sifreC.text}").post({});
//       } catch (e) {
//         Message.show("Hata oluştu her şifre değiştirme işlemi arasında en az 1 saat olmalıdır.");
//         throw Exception(e);
//       }
//     }
//   );
// }),