import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

enum ButtonDSStyle {
  primary,
  secondary,
  blue,
  outline,
  outlineWhite,
  outlineBlue,
  outlineDanger,
  text,
  textBlue,
  textDanger,
  textWhite;

  Color backgroundColor(BuildContext context, {bool disabled = false}) {
    return disabled
        ? _disabledBackgroundColor(context)
        : _enabledBackgroundColor(context);
  }

  Color foregroundColor(BuildContext context, {bool disabled = false}) {
    return disabled
        ? _disabledForegroundColor(context)
        : _enabledForegroundColor(context);
  }

  Color borderColor(BuildContext context, {bool disabled = false}) {
    return disabled
        ? _disabledBorderColor(context)
        : _enabledBorderColor(context);
  }

  Color _enabledBackgroundColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.dark,
      secondary => context.colors.light.shade50,
      blue => context.colors.light600,
      outline => Colors.transparent,
      outlineWhite => Colors.transparent,
      outlineBlue => Colors.transparent,
      outlineDanger => Colors.transparent,
      text => Colors.transparent,
      textBlue => Colors.transparent,
      textDanger => Colors.transparent,
      textWhite => Colors.transparent,
    };
  }

  Color _enabledForegroundColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.light.shade50,
      secondary => context.colors.dark,
      blue => context.colors.light50,
      outline => context.colors.dark,
      outlineWhite => context.colors.base.shade50,
      outlineBlue => context.colors.light.shade900,
      outlineDanger => context.colors.redText,
      text => context.colors.dark,
      textBlue => context.colors.light.shade900,
      textDanger => context.colors.redText,
      textWhite => context.colors.base.shade50,
    };
  }

  Color _enabledBorderColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.dark,
      secondary => context.colors.light.shade50,
      blue => context.colors.light600,
      outline => context.colors.dark,
      outlineWhite => context.colors.base.shade50,
      outlineBlue => context.colors.light.shade900,
      outlineDanger => context.colors.redText,
      text => Colors.transparent,
      textBlue => Colors.transparent,
      textDanger => Colors.transparent,
      textWhite => Colors.transparent,
    };
  }

  Color _disabledBackgroundColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.dark.shade100,
      secondary => context.colors.dark.shade100,
      blue => context.colors.light100,
      outline => Colors.transparent,
      outlineWhite => Colors.transparent,
      outlineBlue => Colors.transparent,
      outlineDanger => Colors.transparent,
      text => Colors.transparent,
      textBlue => Colors.transparent,
      textDanger => Colors.transparent,
      textWhite => Colors.transparent,
    };
  }

  Color _disabledForegroundColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.dark.shade200,
      secondary => context.colors.dark.shade200,
      blue => context.colors.light200,
      outline => context.colors.dark.shade100,
      outlineWhite => context.colors.base.shade100,
      outlineBlue => context.colors.light.shade200,
      outlineDanger => context.colors.redBg,
      text => context.colors.dark.shade100,
      textBlue => context.colors.light.shade200,
      textDanger => context.colors.redBg,
      textWhite => context.colors.base50.withAlpha(70),
    };
  }

  Color _disabledBorderColor(BuildContext context) {
    return switch (this) {
      primary => context.colors.dark.shade100,
      secondary => context.colors.dark.shade100,
      blue => context.colors.light100,
      outline => context.colors.dark.shade100,
      outlineWhite => context.colors.base.shade100,
      outlineBlue => context.colors.light.shade200,
      outlineDanger => context.colors.redBg,
      text => Colors.transparent,
      textBlue => Colors.transparent,
      textDanger => Colors.transparent,
      textWhite => Colors.transparent,
    };
  }
}
