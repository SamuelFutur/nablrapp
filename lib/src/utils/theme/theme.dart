
import 'package:flutter/material.dart';
import 'package:nablr/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData LightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
     primarySwatch: const MaterialColor(0xFF007FFF, <int, Color>{
       50: Color(0xFFE1F5FF),
       100: Color(0xFFB3E5FC),
       200: Color(0xFF81D4FA),
       300: Color(0xFF4FC3F7),
       400: Color(0xFF29B6F6),
       500: Color(0xFF03A9F4),
       600: Color(0xFF039BE5),
       700: Color(0xFF0288D1),
       800: Color(0xFF0277BD),
       900: Color(0xFF01579B),
     },
  ),);
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      primarySwatch: const MaterialColor(0xFF673AB7, <int, Color>{
        50: Color(0xFFEDE7F6),
        100: Color(0xFFD1C4E9),
        200: Color(0xFFB39DDB),
        300: Color(0xFF9575CD),
        400: Color(0xFF7E57C2),
        500: Color(0xFF673AB7),
        600: Color(0xFF5E35B1),
        700: Color(0xFF512DA8),
        800: Color(0xFF4527A0),
        900: Color(0xFF311B92),
      }),
  );
}