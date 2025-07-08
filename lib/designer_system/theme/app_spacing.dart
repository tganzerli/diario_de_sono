import 'dart:ui';
import 'package:flutter/material.dart';

/// A class that defines spacing constants for the app.
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// `4px` Extra extra small spacing.
  final double xxs;

  /// `8px` Extra small spacing.
  final double xs;

  /// `12px` Small spacing.
  final double s;

  /// `16px` Medium spacing.
  final double m;

  /// `24px` Large spacing.
  final double l;

  /// `32px` Extra large spacing.
  final double xl;

  /// `48px` Extra extra large spacing.
  final double xxl;

  /// `64px` Extra extra extra large spacing.
  final double xxxl;

  /// App margin spacing `16px`.
  final double margin;

  final double? _figmaWidth;
  final double? _screenWidth;

  const AppSpacing()
    : xxs = 4,
      xs = 8,
      s = 12,
      m = 16,
      l = 24,
      xl = 32,
      xxl = 48,
      xxxl = 64,
      margin = 16,
      _screenWidth = null,
      _figmaWidth = null;

  AppSpacing._(
    this._screenWidth,
    this._figmaWidth, {
    required this.xxs,
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.margin,
  });

  /// Retrieves the [AppSpacing] instance from the [BuildContext].
  static AppSpacing of(BuildContext context) {
    return Theme.of(context).extension<AppSpacing>()!;
  }

  @override
  AppSpacing copyWith({
    double? xxs,
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
    double? xxl,
    double? xxxl,
    double? margin,
  }) {
    return AppSpacing._(
      _screenWidth,
      _figmaWidth,
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      margin: margin ?? this.margin,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing._(
      _screenWidth,
      _figmaWidth,
      xxs: lerpDouble(xxs, other.xxs, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      s: lerpDouble(s, other.s, t)!,
      m: lerpDouble(m, other.m, t)!,
      l: lerpDouble(l, other.l, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
      xxxl: lerpDouble(xxxl, other.xxxl, t)!,
      margin: lerpDouble(margin, other.margin, t)!,
    );
  }
}
