import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/elevatedbutton_theme.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/outlinedbutton_theme.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/textfield_theme.dart';

class CAppTheme {
  CAppTheme._();//Make constructor private to prevent access from instance
  
  static ThemeData lightTheme = ThemeData(
    // textTheme: CTextTheme.blackTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
    }),
  );
}