import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryLigth = Colors.indigo.shade600;
  static Color primaryDark = Colors.red.shade600;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryLigth,
    appBarTheme:
        AppBarTheme(color: primaryLigth, elevation: 0, centerTitle: true),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryLigth)),
    iconTheme: const IconThemeData().copyWith(color: primaryLigth),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primaryLigth),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom().copyWith(
        backgroundColor: MaterialStateProperty.all(primaryLigth),
        shape: MaterialStateProperty.all(const StadiumBorder()),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: primaryLigth,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryLigth),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryLigth),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      border: const OutlineInputBorder(
        // borderSide: BorderSide(color: primaryLigth),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      iconColor: primaryLigth,
    ),
  );
}
