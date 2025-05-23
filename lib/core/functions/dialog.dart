import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

enum DialogType { error, success, warning }

showMainDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:
          type == DialogType.error
              ? AppColors.redColor
              : type == DialogType.warning
              ? AppColors.orangeColor
              : AppColors.primaryColor,
    ),
  );
}
