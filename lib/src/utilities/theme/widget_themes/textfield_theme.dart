import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class CTextFormFieldTheme {
  CTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = 
    InputDecorationTheme(
      border: const OutlineInputBorder(),
      labelStyle: CTextTheme.greyTextTheme.headlineSmall,
      hintStyle: CTextTheme.greyTextTheme.headlineSmall,
      errorStyle: const TextStyle(color: Colors.red),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: AppColors.cBlueColor2)
      )
    );
}