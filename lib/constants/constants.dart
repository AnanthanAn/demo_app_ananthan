import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';

TextStyle kButtonTextStyle = GoogleFonts.kronaOne(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle kTextFieldLabelStyle =
    GoogleFonts.kronaOne(fontWeight: FontWeight.bold, color: Colors.grey);

TextStyle kHeaderStyles = GoogleFonts.kronaOne(
    fontWeight: FontWeight.bold, color: Colors.blueGrey);

TextStyle kAppBarTitleStyles = GoogleFonts.kronaOne(color: Colors.white);

TextStyle kTitleStyles =
    GoogleFonts.kronaOne(color: Colors.blueGrey, fontSize: 20);
