import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_style.dart';

export 'light_theme.dart';

extension ThemeDataColorsExtension on ThemeData {
  AppColors get colors => extension<AppColors>()!;
}

extension ThemeDataTextsExtension on ThemeData {
  AppTextStyles get textStyles => extension<AppTextStyles>()!;
}

extension ThemeDataSpacingExtension on ThemeData {
  AppSpacing get spaces => extension<AppSpacing>()!;
}

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColors get colors => Theme.of(this).colors;
  AppTextStyles get text => Theme.of(this).textStyles;
  AppSpacing get spaces => Theme.of(this).spaces;
}

extension TextStyleContext on TextStyle {
  TextStyle setColor(Color color) => copyWith(color: color);
}

extension ScreenContext on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
