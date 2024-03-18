import 'package:flutter/material.dart';

class Themes
{
  static const Color mainColor = Color(0xffEB004B);
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color red  = Color(0xffEB004B);
  static const Color orange = Color(0xffff5812);
  static const Color grey = Color(0xff58585B);
  static const Color text = Color(0xff333333);
  static const Color lightGrey = Color(0xffF3F3F4);
  static const Color transparent = Colors.transparent;
  static const Color back = Color(0xffF7F7F7);
  static const Color green = Color(0xff22CA97);

  static BoxDecoration decor = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: light,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1,
          offset: Offset(0,0),
        ),
      ]
  );

  static BoxDecoration decorSettings = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: lightGrey,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          offset: Offset(0,0),
        ),
      ]
  );

  static ThemeData theme = ThemeData(

    useMaterial3: true,
    
    scrollbarTheme: const ScrollbarThemeData(
      thumbColor: MaterialStatePropertyAll(mainColor),
      radius: Radius.circular(10)
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(light),
      trackColor: MaterialStateProperty.resolveWith((states)
      {
        return states.contains(MaterialState.selected) ? mainColor : grey.withOpacity(0.1);
      }),
      overlayColor: MaterialStateProperty.all(mainColor.withOpacity(0.2)),
      splashRadius: 16,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackOutlineColor: MaterialStateProperty.all(lightGrey)
    ),


    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: light,
      surfaceTintColor: light,
      color: light,
      iconTheme: IconThemeData(
        color: text,
      ),
    ),

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
        backgroundColor: mainColor,
        foregroundColor: light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: mainColor,
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: mainColor,
      onPrimary: Colors.white,
      secondary: mainColor,
      onSecondary: Colors.black,
    ),
    splashColor: mainColor,
    canvasColor: light,
    cardColor: mainColor,
    primaryColor: mainColor,
    primarySwatch: MaterialColor(
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
    ),
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