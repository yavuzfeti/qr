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

  static List<BoxShadow> shadow = [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 1,
      offset: Offset(0,0),
    ),
  ];

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
      thumbColor: WidgetStatePropertyAll(mainColor),
      radius: Radius.circular(10)
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(light),
      trackColor: WidgetStateProperty.resolveWith((states)
      {
        return states.contains(WidgetState.selected) ? mainColor : grey.withOpacity(0.1);
      }),
      overlayColor: WidgetStateProperty.all(mainColor.withOpacity(0.2)),
      splashRadius: 16,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackOutlineColor: WidgetStateProperty.all(lightGrey)
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
      bodyLarge: TextStyle(color: text),
      bodyMedium: TextStyle(color: text),
      displayLarge: TextStyle(color: text,),
      displayMedium: TextStyle(color: text,),
      displaySmall: TextStyle(color: text,),
      headlineMedium: TextStyle(color: text,),
      headlineSmall: TextStyle(color: text,),
      titleLarge: TextStyle(color: text,),
      bodySmall: TextStyle(color: text,),
      titleMedium: TextStyle(color: text,),
      titleSmall: TextStyle(color: text,),
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
    splashColor: mainColor,
    canvasColor: light,
    cardColor: mainColor,
    primaryColor: mainColor,
    hintColor: mainColor,
    disabledColor: grey,
    scaffoldBackgroundColor: light,

    fontFamily: "Inter",

    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform,PageTransitionsBuilder>
        {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
    ), colorScheme: const ColorScheme.light(
      primary: mainColor,
      onPrimary: Colors.white,
      secondary: mainColor,
      onSecondary: Colors.black,
    ).copyWith(error: red,surface: light),
  );
}