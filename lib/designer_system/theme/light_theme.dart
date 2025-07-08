import 'package:flutter/material.dart';

import 'app_spacing.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

ThemeData lightTheme(BuildContext context) {
  final colors = AppColors();
  const textStyles = AppTextStyles();

  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: colors.dark,
      onPrimary: colors.light800,
      secondary: colors.light,
      onSecondary: colors.light700,
      error: colors.redError,
      onError: colors.redText,
      surface: colors.light50,
      onSurface: colors.light50,
    ),
    textTheme: asTextTheme(textStyles),
    extensions: [AppColors(), AppTextStyles(), AppSpacing()],
  );
}
