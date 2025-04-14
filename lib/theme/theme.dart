import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
   primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(color: Colors.white),
    )
  );
}