import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MyCustomeText(
    String text, Color color, double fontSize, FontWeight fontWeight) {
  return Text(text,
      style: TextStyle(fontSize: fontSize, color: color),
      maxLines: 1,
      overflow: TextOverflow.ellipsis);
}

MyCustomeGoogleFontText(
    String text, Color color, double fontSize, FontWeight fontWeight) {
  return Text(
    text,
    style: GoogleFonts.nunito(
        fontWeight: fontWeight, fontSize: fontSize, color: color),
  );
}
