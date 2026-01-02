import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsConstant.primaryBackground,
    primaryColor: ColorsConstant.primaryColor,
    textTheme: GoogleFonts.albertSansTextTheme().copyWith(
      titleLarge: GoogleFonts.albertSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorsConstant.primaryBlackText,
      ),
      headlineLarge: GoogleFonts.albertSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorsConstant.primaryBlackText,
      ),
      bodyMedium: GoogleFonts.albertSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsConstant.primaryBlackText,
      ),
      bodySmall: GoogleFonts.albertSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsConstant.primaryGreyText,
      ),
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: ColorsConstant.primaryBackground,
      elevation: 0,
      titleTextStyle: GoogleFonts.albertSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsConstant.primaryBlackText,
      ),
      iconTheme: const IconThemeData(color: ColorsConstant.primaryBlackText),
    ),
    fontFamily: GoogleFonts.albertSans().fontFamily,
    fontFamilyFallback: [GoogleFonts.roboto().fontFamily ?? 'Roboto'],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsConstant.darkBackground,
    primaryColor: ColorsConstant.primaryColor,
    textTheme: GoogleFonts.albertSansTextTheme().copyWith(
      titleLarge: GoogleFonts.albertSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorsConstant.darkTextPrimary,
      ),
      headlineLarge: GoogleFonts.albertSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorsConstant.darkTextPrimary,
      ),
      bodyMedium: GoogleFonts.albertSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsConstant.darkTextPrimary,
      ),
      bodySmall: GoogleFonts.albertSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsConstant.darkTextSecondary,
      ),
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: ColorsConstant.darkBackground,
      elevation: 0,
      titleTextStyle: GoogleFonts.albertSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsConstant.darkTextPrimary,
      ),
      iconTheme: const IconThemeData(color: ColorsConstant.darkTextPrimary),
    ),
    fontFamily: GoogleFonts.albertSans().fontFamily,
    fontFamilyFallback: [GoogleFonts.roboto().fontFamily ?? 'Roboto'],
  );
}
