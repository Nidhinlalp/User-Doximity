import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      dividerColor: kGrayColor800,
      backgroundColor: kWhiteColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.lato().fontFamily,
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          color: kBlackColor900,
          fontSize: 40,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: const TextStyle(
          color: kBlackColor900,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: const TextStyle(
          color: kBlackColor900,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: const TextStyle(
          color: kBlackColor800,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: kGrayColor800,
          fontSize: 14,
          fontFamily: GoogleFonts.sourceSansPro().fontFamily,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: const TextStyle(
          color: kBlackColor900,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
