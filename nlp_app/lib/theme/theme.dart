import 'package:flutter/material.dart';
import 'package:nlp_app/theme/colors.dart';

final ThemeData customDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    primary: primaryAccent,
    secondary: secondaryAccent,
    surface: backgroundColor,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: primaryAccent),
    titleTextStyle: TextStyle(
      color: textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: textPrimary,
    displayColor: textHighlight,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryAccent,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: backgroundColor,
      backgroundColor: Colors.white, // Buton metni beyaz
      elevation: 7,
      shadowColor: primaryAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  ),
  cardColor: primaryAccent,
);
