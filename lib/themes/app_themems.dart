import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 24, 37, 217);
  static const Color secondary = Color.fromARGB(255, 8, 28, 139);
  static const Color backGround = Color.fromARGB(255, 228, 228, 228);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Primary Color
    primaryColor: primary,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      centerTitle: true,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backGround,
      showUnselectedLabels: false,
      selectedItemColor: primary.withOpacity(0.85),
      unselectedItemColor: primary,
    ),

    //TextButton Theme

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primary),
    ),

    //Floation action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      
    ),

    //Elevated button

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),

    scaffoldBackgroundColor: backGround,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Primary Color
    primaryColor: Colors.green,
    brightness: Brightness.dark,
    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
