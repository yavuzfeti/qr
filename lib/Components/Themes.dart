import 'package:flutter/material.dart';

class Themes
{
  static const Color mainColor = Color(0xff9694FF);
  static const Color secondaryColor = Color(0xff6B52F5);
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color red  = Color(0xffEB004B);
  static const Color orange = Color(0xffff5613);
  static const Color grey = Color(0xff58585B);
  static const Color text = dark;
  static const Color lightGrey = Color(0xffF3F3F4);
  static const Color transparent = Colors.transparent;
  static const Color back = Color(0xffF7F7F7);

  static BoxDecoration decor = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(1, 1),
        ),
      ]
  );

  static MaterialColor mainSwatch = MaterialColor(
    mainColor.value,
    const <int, Color>{
      50: Color(0xFFE8E7FF),
      100: Color(0xFFC6C3FF),
      200: Color(0xFFA3A0FF),
      300: Color(0xFF807DFF),
      400: Color(0xFF5E5BFF),
      500: Color(0xFF3B38FF),
      600: Color(0xFF3835E5),
      700: Color(0xFF2B2A99),
      800: Color(0xFF1E1D4D),
      900: Color(0xFF111027),
    }
  );

  static MaterialColor secondarySwatch = MaterialColor(
    secondaryColor.value,
    const <int, Color>{
      50: Color(0xFFE6E5FF),
      100: Color(0xFFC0BEFF),
      200: Color(0xFF9A98FF),
      300: Color(0xFF746EFF),
      400: Color(0xFF4E49FF),
      500: Color(0xFF2823FF),
      600: Color(0xFF2420E5),
      700: Color(0xFF1B1A99),
      800: Color(0xFF13134D),
      900: Color(0xFF0C0C27),
    },
  );

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: text),
      bodyText2: TextStyle(color: text),
      headline1: TextStyle(color: text,),
      headline2: TextStyle(color: text,),
      headline3: TextStyle(color: text,),
      headline4: TextStyle(color: text,),
      headline5: TextStyle(color: text,),
      headline6: TextStyle(color: text,),
      caption: TextStyle(color: text,),
      subtitle1: TextStyle(color: text,),
      subtitle2: TextStyle(color: text,),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: mainColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: text,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: mainColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.black,
    ),
    splashColor: secondaryColor,
    canvasColor: light,
    cardColor: secondaryColor,
    primaryColor: mainColor,
    primarySwatch: mainSwatch,
    hintColor: mainColor,
    backgroundColor: light,
    disabledColor: grey,
    errorColor: red,
    scaffoldBackgroundColor: light,

    fontFamily: "Inter",

    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform,PageTransitionsBuilder>
        {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
    ),
  );
}