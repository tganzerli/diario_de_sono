import 'package:flutter/material.dart';

import 'package:diario_de_sono/designer_system/designer_system.dart';

import 'number_mask.dart';

class IntField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final double? width;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function(String?)? onSubmitted;
  final String? hintText;
  final bool isError;
  const IntField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.width,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      cursorColor: context.colors.dark,
      onFieldSubmitted: onSubmitted,
      onSaved: onSubmitted,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: context.text.headlineMedium.setColor(
        isError ? context.colors.redError : context.colors.dark,
      ),
      inputFormatters: [NumberMask(mask: ''.padLeft(maxLength ?? 2, '#'))],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.text.headlineMedium.setColor(context.colors.dark300),
        errorText: null,
        errorStyle: TextStyle(fontSize: 0, height: 0),
        filled: true,
        fillColor: context.colors.light50,
        hoverColor: context.colors.light50,
        constraints: BoxConstraints.expand(height: 64, width: width),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spaces.s,
          vertical: context.spaces.s,
        ),
        disabledBorder: _border(context),
        enabledBorder: _border(context),
        errorBorder: _border(context),
        focusedErrorBorder: _border(context),
        focusedBorder: _border(context),
      ),
    );
  }

  OutlineInputBorder _border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.spaces.m),
      borderSide: BorderSide(color: context.colors.light900, width: 1),
    );
  }
}
