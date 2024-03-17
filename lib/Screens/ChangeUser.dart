import 'package:flutter/material.dart';
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

  List<Widget> items=[];

  run() async
  {
    if(widget.item=="password")
    {
      setState(() {
        title = "Şifre";
      });
    }
    else if(widget.item=="name")
    {
      setState(() {
        title = "Ad Soyad";
      });
    }
    else if(widget.item=="phone")
    {
      setState(() {
        title = "Telefon";
      });
    }
    else if(widget.item=="mail")
    {
      setState(() {
        title = "E-posta";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title),
      body: Column(
        children: items,
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