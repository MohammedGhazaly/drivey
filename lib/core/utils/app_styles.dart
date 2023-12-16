import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static textStyle(
      {required double fontSize,
      required Color color,
      FontWeight fontWeight = FontWeight.normal}) {
    return GoogleFonts.montserrat(
        fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
