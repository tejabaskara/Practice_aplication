import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text textStyle(String text, double fontSize) {
  return Text(
    "${text}",
    style: GoogleFonts.inter(
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
    ),
  );
}

Text textBoldStyle(String text, double fontSize) {
  return Text(
    "${text}",
    style: GoogleFonts.inter(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    ),
  );
}
