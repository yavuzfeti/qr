import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:qr/Components/Base.dart';
import 'package:qr/Components/Message.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Utils/Network.dart';
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

  isActiveFun()
  {
    setState(() {
      isActive = usernameC.text.isNotEmpty && passwordC.text.isNotEmpty;
    });
  }

  dynamic response;
  bool loading = false;

  login() async
  {
    setState(() {
      loading = true;
    });
    try {
      response = await Network("auth/login").post(
          {
            "username" : usernameC.text.substring(7).replaceAll(" ", "").replaceAll(")", ""),
            "password" : passwordC.text
          }
      );
      await storage.write(key: "id", value: response["response"]["id"].toString() ?? "Veri yok");
      await storage.write(key: "name", value: response["response"]["name"].toString() ?? "Veri yok");
      await storage.write(key: "surname", value: response["response"]["surname"].toString() ?? "Veri yok");
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
                  height: MediaQuery.sizeOf(context).height/2,
                  decoration: BoxDecoration(
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
                    child: Center(child: Text("Hoşgeldiniz!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                  )
                ),
                Positioned(
                  bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset("lib/Assets/Images/Torso.png"),
                ),
              ],
            ),
            Container(
              color: Themes.light,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.all(15),
                      child: Text("Telefon NO:"),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          Center(
                            child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Themes.grey),
                                hintText: "+90 | (5xx) xxx xx xx",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      width: 0,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 0,
                                  )
                                )
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
                                  _pageController.animateToPage(
                                    1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                                isActiveFun();
                              },
                            ),
                          ),
                        Center(
                          child: PinCodeTextField(
                            autofocus: true,
                            focusNode: passFocus,
                            controller: passwordC,
                            pinBoxBorderWidth: 0,
                          pinBoxColor: Themes.lightGrey,
                          pinBoxRadius: 15,
                          maxLength: 6,
                            wrapAlignment: WrapAlignment.center,
                            pinBoxHeight: 40,
                            pinBoxWidth: 40,
                            hideCharacter: true,
                            onDone: (v)
                            {
                              isActiveFun();
                              if(isActive){login();}
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
            loading
                ? Center(child: CircularProgressIndicator(),)
                : Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                  onPressed: isActive ? login : null,
                  child: Text("Doğrula")
              ),
            ),
          ],
        ),
      )
    );
  }
}
