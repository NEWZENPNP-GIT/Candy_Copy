import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme() {
  return TextTheme(
    headline1:
        GoogleFonts.nanumGothic(fontSize: 20, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.nanumGothic(fontSize: 18, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.nanumGothic(fontSize: 16, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.nanumGothic(fontSize: 24, fontWeight: FontWeight.bold),
    subtitle1:
        GoogleFonts.nanumGothic(fontSize: 14, fontWeight: FontWeight.bold),
    subtitle2:
        GoogleFonts.nanumGothic(fontSize: 12, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.nanumGothic(fontSize: 14),
    bodyText2: GoogleFonts.nanumGothic(fontSize: 12),
  );
}

ThemeData mainTheme() {
  return ThemeData(primaryColor: primaryColor, textTheme: textTheme());
}
