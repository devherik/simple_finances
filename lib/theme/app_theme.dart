import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: gbl.lightColor,
      ),
      scaffoldBackgroundColor: gbl.lightColor,
      primarySwatch: Colors.lightGreen,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      useMaterial3: true,
      fontFamily: GoogleFonts.robotoSlab().fontFamily,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.transparent,
      ),
      scaffoldBackgroundColor: Colors.black,
      primarySwatch: Colors.lightGreen,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      useMaterial3: true,
      fontFamily: GoogleFonts.robotoSlab().fontFamily,
    );
  }
}
