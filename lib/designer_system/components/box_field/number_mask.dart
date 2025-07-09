import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberMask extends TextInputFormatter {
  final String mask;
  NumberMask({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var valeu = newValue.text.replaceAll(RegExp(r'\D'), '');
    var formatted = mask;
    for (var i = 0; i < valeu.length; i++) {
      formatted = formatted.replaceFirst('#', valeu[i]);
    }

    final lastHash = formatted.indexOf('#');

    if (lastHash != -1) {
      formatted = formatted.characters.getRange(0, lastHash).join();
      if (RegExp(r'\s\D$').hasMatch(formatted)) {
        formatted = formatted
            .split('')
            .getRange(0, formatted.length - 2)
            .join();
      } else if (RegExp(r'\D\s$').hasMatch(formatted)) {
        formatted = formatted
            .split('')
            .getRange(0, formatted.length - 2)
            .join();
      } else if (RegExp(r'\D$').hasMatch(formatted)) {
        formatted = formatted
            .split('')
            .getRange(0, formatted.length - 1)
            .join();
      }
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
