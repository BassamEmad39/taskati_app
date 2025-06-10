import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class AppThemes {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.poppins,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.whiteColor,
        fontFamily: AppFonts.poppins,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: AppColors.whiteColor),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getSmallTextStyle(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );

  static get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor,
        fontFamily: AppFonts.poppins,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.whiteColor,
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: AppColors.darkColor),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkColor,
      hourMinuteTextColor: AppColors.primaryColor,
      dayPeriodTextColor: AppColors.primaryColor,
      dialHandColor: AppColors.primaryColor,
      dialBackgroundColor: AppColors.darkColor,
    ),
    fontFamily: AppFonts.poppins,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getSmallTextStyle(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );
}
