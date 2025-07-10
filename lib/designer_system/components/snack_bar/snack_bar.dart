import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

class SnackBarDS {
  final BuildContext context;
  final String message;

  SnackBarDS(this.context, this.message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.spaces.s),
        ),
        margin: EdgeInsets.all(context.spaces.margin),
        backgroundColor: context.colors.dark,
        content: Text(
          message,
          style: context.text.labelLarge.setColor(context.colors.light50),
        ),
      ),
    );
  }
}
