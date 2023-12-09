import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Utils/Network.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(
      onPressed: () async
      {
        await storage.write(key: "session", value: "1");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()));
      },
      child: Text("giriş yap"),
    ),);
  }
}
