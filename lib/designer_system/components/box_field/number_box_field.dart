import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

import 'int_field.dart';

class NumberBoxField extends StatefulWidget {
  final void Function(int? time, bool end)? callback;
  final bool requestFocus;
  final int maxLength;
  final int? initialValue;
  const NumberBoxField({
    super.key,
    this.callback,
    this.requestFocus = false,
    this.maxLength = 2,
    this.initialValue,
  });

  @override
  State<NumberBoxField> createState() => _NumberBoxFieldState();
}

class _NumberBoxFieldState extends State<NumberBoxField> {
  String? _errorText;

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  int? _number;

  void _setNumber() {
    if (controller.text.isNotEmpty) {
      _number = int.parse(controller.text);
    } else {
      _number = null;
    }
    _callback();
  }

  void _callback() {
    if (widget.callback != null) {
      final end =
          _number != null && _number.toString().length == widget.maxLength;
      widget.callback!(_number, end);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.requestFocus) {
      focusNode.requestFocus();
    }
    if (widget.initialValue != null) {
      controller.text = widget.initialValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [_textBox(context), _error(context)]);
  }

  Widget _error(BuildContext context) {
    return Text(
      _errorText ?? '',
      style: context.text.labelLarge.setColor(context.colors.redError),
    );
  }

  Widget _textBox(BuildContext context) {
    return IntField(
      width: 58,
      controller: controller,
      focusNode: focusNode,
      hintText: ''.padLeft(widget.maxLength, '0'),
      maxLength: widget.maxLength,
      onSubmitted: (p0) {
        _setNumber();
      },
      onChanged: (number) {
        _setNumber();
      },
    );
  }
}
