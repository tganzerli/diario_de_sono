import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const AppTextStyles({
    this.displayLarge = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.displayMedium = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.displaySmall = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.headlineLarge = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.headlineMedium = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.headlineSmall = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.titleLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.titleMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.titleSmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.bodyLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.bodyMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.bodySmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: _defaultColor,
    ),
    this.labelLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _defaultColor,
    ),
    this.labelMedium = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _defaultColor,
    ),
    this.labelSmall = const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: _defaultColor,
    ),
  });

  static const _defaultColor = Color(0xFF0E3866);

  @override
  AppTextStyles copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return AppTextStyles(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;

    return AppTextStyles(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

TextTheme asTextTheme(AppTextStyles styles) {
  return TextTheme(
    displayLarge: styles.displayLarge,
    displayMedium: styles.displayMedium,
    displaySmall: styles.displaySmall,
    headlineLarge: styles.headlineLarge,
    headlineMedium: styles.headlineMedium,
    headlineSmall: styles.headlineSmall,
    titleLarge: styles.titleLarge,
    titleMedium: styles.titleMedium,
    titleSmall: styles.titleSmall,
    bodyLarge: styles.bodyLarge,
    bodyMedium: styles.bodyMedium,
    bodySmall: styles.bodySmall,
    labelLarge: styles.labelLarge,
    labelMedium: styles.labelMedium,
    labelSmall: styles.labelSmall,
  );
}
