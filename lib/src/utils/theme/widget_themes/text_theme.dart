
import 'package:flutter/material.dart';


class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
      headline2: TextStyle(
        color: Colors.black87,
        fontFamily: "CormorantGaramond",
      ),
      subtitle2: TextStyle(
        color: Colors.black54,
        fontFamily: "CormorantGaramond",
      ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline2: TextStyle(
      fontFamily: "CormorantGaramond",
    ),
    subtitle2: TextStyle(
      fontFamily: "CormorantGaramond",
      fontSize: 24,
    ),
  );
}