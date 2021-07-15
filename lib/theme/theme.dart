import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const highEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.87);
const mediumEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.6);
const lowEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.08);
const highEmphasisWhite = Color.fromRGBO(255, 255, 255, 0.80);
const mediumEmphasisWhite = Color.fromRGBO(255, 255, 255, 0.67);
const lowEmphasisWhite = Color.fromRGBO(255, 255, 255, 0.08);
const primaryColor = Color(0xFF6200EA);
const surface = Color(0xFFFAFAFA);

final lightTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColor: primaryColor,
  accentColor: primaryColor,
  fontFamily: GoogleFonts.getFont('Overpass').fontFamily,
  textTheme: TextTheme(
    headline3: TextStyle(
      fontSize: 48,
      color: highEmphasisBlack,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 30,
      color: highEmphasisBlack,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: 18,
      color: highEmphasisBlack,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    button: TextStyle(color: Colors.white),
    caption: TextStyle(fontSize: 12, color: mediumEmphasisBlack),
    subtitle1: TextStyle(fontSize: 16, color: mediumEmphasisBlack),
    subtitle2: TextStyle(fontSize: 14, color: mediumEmphasisBlack),
  ),
  backgroundColor: surface,
  cardTheme: CardTheme(
    elevation: 3,
    shadowColor: Colors.black.withOpacity(0.15),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      minimumSize: Size.fromHeight(48.0),
      shadowColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
    unselectedItemColor: mediumEmphasisBlack,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(fontWeight: FontWeight.bold),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: lowEmphasisBlack,
    filled: true,
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  primaryColor: primaryColor,
  accentColor: primaryColor,
  fontFamily: GoogleFonts.getFont('Overpass').fontFamily,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    headline3: TextStyle(
      fontSize: 48,
      color: highEmphasisWhite,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 30,
      color: highEmphasisWhite,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: 18,
      color: highEmphasisWhite,
      fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
      fontWeight: FontWeight.bold,
    ),
    button: TextStyle(color: Colors.white),
    caption: TextStyle(fontSize: 12, color: mediumEmphasisWhite),
    subtitle1: TextStyle(fontSize: 16, color: mediumEmphasisWhite),
    subtitle2: TextStyle(fontSize: 14, color: mediumEmphasisWhite),
  ),
  backgroundColor: Colors.black,
  cardTheme: CardTheme(
    elevation: 1,
    color: Colors.white.withOpacity(0.10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      minimumSize: Size.fromHeight(48.0),
      shadowColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: primaryColor,
    unselectedItemColor: mediumEmphasisWhite,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(fontWeight: FontWeight.bold),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white.withOpacity(0.14),
    filled: true,
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  ),
);
