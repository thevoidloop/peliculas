import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryLigth = Colors.indigo.shade600;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryLigth,
    appBarTheme:
        AppBarTheme(color: primaryLigth, elevation: 0, centerTitle: true),
  );

  static const TextStyle title1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
