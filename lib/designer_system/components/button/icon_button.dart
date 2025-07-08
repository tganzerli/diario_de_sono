import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

export 'styles.dart';

class IconButtonDS extends StatelessWidget {
  final double height;
  final double? width;
  final (double, double) padding;

  final VoidCallback? onPressed;
  final IconData icon;

  final Color? color;
  final Color? disabledColor;

  final bool disabled;
  final bool isLoading;

  const IconButtonDS({
    super.key,
    this.height = 32,
    this.width,
    this.padding = (0, 0),
    this.onPressed,
    required this.icon,
    this.color,
    this.disabledColor,
    this.disabled = false,
    this.isLoading = false,
  });

  Color iconColor(BuildContext context, {required bool disabled}) {
    Color defaultColor = color ?? context.colors.dark;
    Color defaultDisabledColore = disabledColor ?? context.colors.base200;
    return disabled ? defaultDisabledColore : defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        fixedSize: Size(width ?? double.infinity, height),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        overlayColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: padding.$1,
          vertical: padding.$2,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? _circleProgress(context, disabled: disabled || onPressed == null)
          : _iconWidget(context, disabled: disabled || onPressed == null),
    );
  }

  Widget _circleProgress(BuildContext context, {required bool disabled}) {
    return Center(
      child: SizedBox(
        width: height * 0.8,
        height: height * 0.8,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            iconColor(context, disabled: disabled),
          ),
        ),
      ),
    );
  }

  Widget _iconWidget(BuildContext context, {required bool disabled}) {
    return Center(
      child: Icon(
        icon,
        color: iconColor(context, disabled: disabled),
        size: height * 0.9,
      ),
    );
  }
}
