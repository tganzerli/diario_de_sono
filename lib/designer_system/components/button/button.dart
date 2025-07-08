import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

export 'styles.dart';

class ButtonDS extends StatelessWidget {
  const ButtonDS._({
    required super.key,
    required this.style,
    required this.height,
    required this.width,
    required this.textStyle,
    required this.padding,
    required this.spacing,
    required this.borderRadius,
    required this.label,
    required this.onPressed,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.iconSize,
    required this.disabled,
    required this.isLoading,
  });

  factory ButtonDS.full({
    Key? key,
    ButtonDSStyle style = ButtonDSStyle.primary,
    double? width,
    String? label,
    VoidCallback? onPressed,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool disabled = false,
    bool isLoading = false,
  }) => ButtonDS._(
    key: key,
    textStyle: 'labelLarge',
    height: 48,
    padding: (12, 4),
    spacing: 10,
    borderRadius: 8,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    iconSize: 24,
    width: width,
    style: style,
    label: label,
    onPressed: onPressed,
    disabled: disabled,
    isLoading: isLoading,
  );

  factory ButtonDS.small({
    Key? key,
    ButtonDSStyle style = ButtonDSStyle.primary,
    double? width,
    String? label,
    VoidCallback? onPressed,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool disabled = false,
    bool isLoading = false,
  }) => ButtonDS._(
    key: key,
    textStyle: 'labelMedium',
    height: 32,
    padding: (8, 4),
    spacing: 8,
    borderRadius: 8,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    iconSize: 24,
    width: width,
    style: style,
    label: label,
    onPressed: onPressed,
    disabled: disabled,
    isLoading: isLoading,
  );

  factory ButtonDS.extraSmall({
    Key? key,
    ButtonDSStyle style = ButtonDSStyle.primary,
    double? width,
    String? label,
    VoidCallback? onPressed,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool disabled = false,
    bool isLoading = false,
  }) => ButtonDS._(
    key: key,
    textStyle: 'labelSmall',
    height: 24,
    padding: (8, 2),
    spacing: 4,
    borderRadius: 8,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    iconSize: 18,
    width: width,
    style: style,
    label: label,
    onPressed: onPressed,
    disabled: disabled,
    isLoading: isLoading,
  );

  ButtonDS setStyle(ButtonDSStyle style) {
    return ButtonDS._(
      key: key,
      textStyle: textStyle,
      height: height,
      padding: padding,
      spacing: spacing,
      borderRadius: borderRadius,
      width: width,
      style: style,
      label: label,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      iconSize: iconSize,
      disabled: disabled,
      isLoading: isLoading,
    );
  }

  final ButtonDSStyle style;
  final double height;
  final double? width;
  final String textStyle;
  final (double, double) padding;
  final double spacing;
  final double borderRadius;

  final String? label;
  final VoidCallback? onPressed;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double iconSize;

  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        fixedSize: Size(width ?? double.infinity, height),
        backgroundColor: style.backgroundColor(context),
        foregroundColor: style.foregroundColor(context),
        disabledBackgroundColor: style.backgroundColor(context, disabled: true),
        disabledForegroundColor: style.foregroundColor(context, disabled: true),
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: padding.$1,
          vertical: padding.$2,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: style.borderColor(
              context,
              disabled: disabled || onPressed == null,
            ),
            width: 1,
          ),
        ),
      ),
      child: isLoading
          ? _circleProgress(context, disabled: disabled || onPressed == null)
          : _labelWidget(context, disabled: disabled || onPressed == null),
    );
  }

  Widget _circleProgress(BuildContext context, {required bool disabled}) {
    return Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            style.foregroundColor(context, disabled: disabled),
          ),
        ),
      ),
    );
  }

  Widget _labelWidget(BuildContext context, {required bool disabled}) {
    final textTheme = switch (textStyle) {
      'labelLarge' => context.text.labelLarge.copyWith(
        color: style.foregroundColor(context, disabled: disabled),
      ),
      'labelMedium' => context.text.labelMedium.copyWith(
        color: style.foregroundColor(context, disabled: disabled),
      ),
      'labelSmall' => context.text.labelSmall.copyWith(
        color: style.foregroundColor(context, disabled: disabled),
      ),
      _ => context.text.labelLarge.copyWith(
        color: style.foregroundColor(context, disabled: disabled),
      ),
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spacing,
      children: [
        if (prefixIcon != null) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: Icon(
              prefixIcon,
              color: style.foregroundColor(context, disabled: disabled),
              size: iconSize,
            ),
          ),
        ],
        if (label != null) ...[Text(label!, style: textTheme)],
        if (suffixIcon != null) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: Center(
              child: Icon(
                suffixIcon,
                color: style.foregroundColor(context, disabled: disabled),
                size: iconSize,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
