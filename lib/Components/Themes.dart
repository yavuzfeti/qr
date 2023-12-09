import 'package:flutter/material.dart';

class Themes
{
  static const Color mainColor = Color(0xff9694FF);
  static const Color secondaryColor = Color(0xff6B52F5);
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color red  = Color(0xffEB004B);
  static const Color orange = Color(0xffff5613);
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;
  static const Color back = light;

  static MaterialColor mainSwatch = MaterialColor(
    mainColor.value,
    const <int, Color>{
      200: Color(0xFFA3A0FF),
      300: Color(0xFF807DFF),
      400: Color(0xFF5E5BFF)
    }
  );

  static MaterialColor secondarySwatch = MaterialColor(
    secondaryColor.value,
    const <int, Color>{
      200: Color(0xFF9A98FF),
      300: Color(0xFF746EFF),
      400: Color(0xFF4E49FF),
    },
  );

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: secondaryColor),
      bodyText2: TextStyle(color: secondaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        foregroundColor: light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: mainColor,
      ),
    ),
    cardTheme: const CardTheme(
      color: secondaryColor,
      elevation: 4,
    ),
    dividerColor: secondaryColor,
    tabBarTheme: const TabBarTheme(
      labelColor: light,
      unselectedLabelColor: grey,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: light,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: mainColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.black,
    ),
    canvasColor: light,
    cardColor: secondaryColor,
    primaryColor: mainColor,
    primarySwatch: mainSwatch,
    hintColor: mainColor,
    backgroundColor: light,
    disabledColor: grey,
    errorColor: red,
    scaffoldBackgroundColor: light,

    // fontFamily: "",

    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform,PageTransitionsBuilder>
        {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
    ),
  );
}