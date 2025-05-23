import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

class TextStyles {
  static TextStyle getTitleTextStyle({
    double fontSize = 24,
    Color color = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  static TextStyle getSmallTextStyle({
    double fontSize = 14,
    Color color = AppColors.greyColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  static TextStyle getBodyTextStyle({
    double fontSize = 16,
    Color color = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
