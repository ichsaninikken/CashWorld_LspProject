import 'package:flutter/material.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, const Color.fromRGBO(160,82,45,1.000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primaryColor = const Color.fromRGBO(160,82,45,1.000);
  static Color primaryExtraSoft = const Color.fromRGBO(239, 243, 252, 1);
  static Color secondary = const Color.fromRGBO(240, 128, 128, 1.000); //
  static Color secondarySoft = const Color.fromRGBO(157, 157, 157, 1);
  static Color secondaryExtraSoft = const Color.fromRGBO(233, 233, 233, 1);
  static Color warning = const Color.fromRGBO(247, 203, 132, 1);
  static Color dark = const Color.fromRGBO(71,69,62,1.000);
  static Color softChocolate = const Color.fromRGBO(210,180,140,1.000);
  static Color outRed = const Color.fromRGBO(205,92,92,1.000); //

  static const Color contentColorGreen = Color.fromRGBO(0,128,0,1.000);
  static const Color contentColorRed = Color.fromRGBO(235,50,35,1.000);
}
