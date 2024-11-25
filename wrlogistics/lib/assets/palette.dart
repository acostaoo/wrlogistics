import 'package:flutter/material.dart';

class AppColors{
  static const primary = Color(0xFF1D64F2);
  static const lightPrimary = Color(0xFF4BB2F2);
  static const secondary =Color(0xFFF24E29);
  static const lightSecondary = Color(0xFFF2B705);
  static const ligherPrimary =Color(0xFF66E4F2);

}

  
final ThemeData appTheme = ThemeData(
  primaryColorLight: AppColors.primary,
  secondaryHeaderColor:AppColors.secondary,
);