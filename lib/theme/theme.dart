import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const highEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.87);
const mediumEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.6);
const lowEmphasisBlack = Color.fromRGBO(0, 0, 0, 0.08);
const primaryColor = Color(0xFF6200EA);
const surface = Color(0xFFFAFAFA);

class AppTheme {
  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.getFont('Overpass').fontFamily,
        textTheme: TextTheme(
          headline4: TextStyle(
            fontSize: 30,
            color: highEmphasisBlack,
            fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: surface,
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
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
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
}
