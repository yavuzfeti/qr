import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/Utils/NotificationBackground.dart';
import 'package:qr/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController usernameC = MaskedTextController(mask: "+90 | (500) 000 00 00");
  TextEditingController passwordC = TextEditingController();

  FocusNode userFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    usernameC.dispose();
    passwordC.dispose();
  }

  bool isActive = false;

  String macId = "";

  isActiveFun()
  {
    setState(() {
      isActive = usernameC.text.isNotEmpty && passwordC.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    al();
  }

  al() async
  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    macId = androidInfo.fingerprint;
  }

  dynamic response;
  bool loading = false;
  String label = "Telefon";

  login() async
  {
    setState(() {
      loading = true;
    });
    try {
      response = await Network("auth/login").post(
          {
            "username" : usernameC.text.substring(7).replaceAll(" ", "").replaceAll(")", ""),
            "password" : passwordC.text,
            "mac_id": macId
          }
      );
      await storage.write(key: "id", value: response["response"]["id"].toString() ?? "Veri yok");
      await storage.write(key: "name", value: response["response"]["name"].toString() ?? "Veri yok");
      await storage.write(key: "phone_code", value: response["response"]["phone_code"].toString() ?? "Veri yok");
      await storage.write(key: "phone", value: response["response"]["phone"].toString() ?? "Veri yok");
      await storage.write(key: "company", value: response["response"]["company"].toString() ?? "Veri yok");
      await storage.write(key: "branch", value: response["response"]["branch"].toString() ?? "Veri yok");
      await storage.write(key: "work_plan", value: response["response"]["work_plan"].toString() ?? "Veri yok");
      await storage.write(key: "gender", value: response["response"]["gender"].toString() ?? "Veri yok");
      await storage.write(key: "contract_type", value: response["response"]["contract_type"].toString() ?? "Veri yok");
      await storage.write(key: "access_type", value: response["response"]["access_type"].toString() ?? "Veri yok");
      await storage.write(key: "email", value: response["response"]["email"].toString() ?? "Veri yok");
      await storage.write(key: "email_verified_at", value: response["response"]["email_verified_at"].toString() ?? "Veri yok");
      await storage.write(key: "two_factor_secret", value: response["response"]["two_factor_secret"].toString() ?? "Veri yok");
      await storage.write(key: "two_factor_recovery_codes", value: response["response"]["two_factor_recovery_codes"].toString() ?? "Veri yok");
      await storage.write(key: "two_factor_confirmed_at", value: response["response"]["two_factor_confirmed_at"].toString() ?? "Veri yok");
      await storage.write(key: "current_team_id", value: response["response"]["current_team_id"].toString() ?? "Veri yok");
      await storage.write(key: "profile_photo_path", value: response["response"]["profile_photo_path"].toString() ?? "Veri yok");
      await storage.write(key: "created_at", value: response["response"]["created_at"].toString() ?? "Veri yok");
      await storage.write(key: "updated_at", value: response["response"]["updated_at"].toString() ?? "Veri yok");

      await storage.write(key: "username", value: usernameC.text);
      await storage.write(key: "password", value: passwordC.text);

      await storage.write(key: "session", value: "1");

      await NotificationBackground.add(response["response"]["id"].toString());
      await NotificationBackground.add(response["response"]["current_team_id"].toString());
      await NotificationBackground.add(response["response"]["company"].toString());

      Navigator.pushAndRemoveUntil(
        navKey.currentState!.context,
        MaterialPageRoute(builder: (context) => Base()),
            (Route<dynamic> route) => false,
      );
    }
    catch (e)
    {
      setState(() {
        loading = false;
      });
      Message.show("Bir hata oluştu");
      rethrow;
    }
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: (MediaQuery.sizeOf(context).height/2)-75,
                  decoration: const BoxDecoration(
                    color: Themes.back
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height/5,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(-1, -1),
                          ),
                        ],
                      color: Themes.light,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                    ),
                    child: const Center(child: Text("Hoşgeldiniz!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                  )
                ),
                Positioned(
                  bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: SvgPicture.asset("lib/Assets/Images/torso.svg"),
                    ),
                ),
              ],
            ),
            Container(
              color: Themes.light,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height/5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Themes.lightGrey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                    color: Themes.light,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                      child: Text(label),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (v)
                        {
                        if(usernameC.text.length > 20)
                        {
                        userFocus.unfocus();
                        setState(() {
                        label = "Şifre";
                        });
                        isActiveFun();
                        }
                        else{
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                        },
                        children: [
                          Center(
                            child: TextField(
                              autofocus: true,
                              cursorColor: Themes.grey,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Themes.grey),
                                hintText: "+90 | (5xx) xxx xx xx",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              controller: usernameC,
                              focusNode: userFocus,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(21)
                              ],
                              onChanged: (v)
                              {
                                if(usernameC.text.length > 20)
                                {
                                  userFocus.unfocus();
                                  setState(() {
                                    label = "Şifre";
                                  });
                                  _pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                                isActiveFun();
                              },
                            ),
                          ),
                        Center(
                          child: TextField(
                            autofocus: true,
                            cursorColor: Themes.grey,
                            focusNode: passFocus,
                            controller: passwordC,
                            obscureText: true,
                            obscuringCharacter: "*",
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "******",
                              hintStyle: TextStyle(color: Themes.grey),
                              border: InputBorder.none
                            ),
                            onChanged: (v)
                            {
                              isActiveFun();
                            },
                          ),
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: Text("Lütfen devam etmek için bilgilerinizi girin. Ardından 'Doğrula' butonuna tıklayın!",textAlign: TextAlign.center,style: TextStyle(color: Colors.black26,fontSize: 13),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 125,
        color: Themes.light,
        elevation: 0,
        child: loading
            ? const Center(child: CircularProgressIndicator(),)
            : Padding(
          padding: const EdgeInsets.all(25),
          child: ElevatedButton(
              onPressed: isActive ? login : null,
              child: const Text("Doğrula")
          ),
        ),
      ),
      floatingActionButton: (userFocus.hasFocus || passFocus.hasFocus )
          ? Container(
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
                onPressed:()
                {
                  setState(() {
                    userFocus.unfocus();
                    passFocus.unfocus();
                  });
                },
                  child: const Text("Bitti")
              )
            ],
          ),
        ),
      ) : null,
    );
  }
}
