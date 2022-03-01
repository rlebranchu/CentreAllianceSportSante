import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _PRIMARYCOLOR = Color(0xFF5F5F5F);

// Definition of Theme Application
// Contains differents subthemes which represent each one theme for widgets (input, button, text, etc.)
class AppTheme {
  ThemeData get Theme => ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: _PRIMARYCOLOR,
      scaffoldBackgroundColor: Colors.white,
      // Define the default font family.
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _PRIMARYCOLOR,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 10.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: _PRIMARYCOLOR, fontSize: 30.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(color: _PRIMARYCOLOR, fontSize: 14.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Montserrat'),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ));
}
