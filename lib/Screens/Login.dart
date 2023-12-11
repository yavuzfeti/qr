import 'package:flutter/material.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  bool isSecret = true;
  bool isActive = false;

  void passwordIsSecret()
  {
    setState(() {
      isSecret = !isSecret;
    });
  }

  isActiveFun()
  {
    setState(() {
      isActive = usernameC.text.isNotEmpty && passwordC.text.isNotEmpty;
    });
  }

  void login() async
  {
    await storage.write(key: "session", value: "1");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()));
  }

  InputDecoration inpdec(IconData icon, String label, String hint, bool P) {
    return InputDecoration(
      prefixIconColor: Themes.mainColor,
      prefixIcon: P ? IconButton(
          onPressed: passwordIsSecret,
          icon: Icon(isSecret ? Icons.key_rounded : Icons.key_off_rounded)
      ): Icon(icon),
      labelText: label,
      labelStyle: TextStyle(color: Themes.mainColor, fontSize: 20),
      hintText: hint,
      hintStyle: TextStyle(color: Themes.secondaryColor, fontSize: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Themes.mainColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Themes.mainColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("lib/Assets/Images/logo.png"),
              SizedBox(height: 25,),
              Text("Hoşgeldiniz",style: TextStyle(fontSize: 25),),
              SizedBox(height: 25,),
              TextField(
                controller: usernameC,
                decoration: inpdec(Icons.account_circle_rounded, "Kullanıcı adı", "E-postanızı giriniz", false),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: passwordC,
                decoration: inpdec(Icons.key_rounded, "Şifre", "Şifrenizi giriniz", true),
              ),
              SizedBox(height: 25,),
              ElevatedButton(
                onPressed: isActive ? login : null,
                child: Text("GİRİŞ YAP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
