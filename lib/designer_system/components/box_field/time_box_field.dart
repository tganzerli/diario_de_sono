import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

import '../../../core/value_object/value_object.dart';
import 'int_field.dart';

class TimeBoxField extends StatefulWidget {
  final void Function(OfTime? time, bool end)? callback;
  final bool requestFocus;
  final OfTime? initialValue;
  const TimeBoxField({
    super.key,
    this.callback,
    this.requestFocus = false,
    this.initialValue,
  });

  @override
  State<TimeBoxField> createState() => _TimeBoxFieldState();
}

class _TimeBoxFieldState extends State<TimeBoxField> {
  String? _errorText;

  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  FocusNode hoursFocusNode = FocusNode();
  FocusNode minutesFocusNode = FocusNode();

  OfTime? time;

  void _setTime() {
    if (hoursController.text.isNotEmpty && minutesController.text.isNotEmpty) {
      final hours = hoursController.text.padLeft(2, '0');
      final minutes = minutesController.text.padLeft(2, '0');
      time = OfTime('$hours:$minutes');
    } else {
      time = null;
    }
    if (time != null) {
      setState(() {
        _errorText = time!.validate().isError() ? 'Tempo inválido' : null;
      });
    }
    _callback();
  }

  void _callback() {
    if (widget.callback != null) {
      final end =
          time != null &&
          time!.validate().isSuccess() &&
          minutesController.text.length == 2;
      widget.callback!(time, end);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.requestFocus) {
      hoursFocusNode.requestFocus();
    }
    if (widget.initialValue != null &&
        widget.initialValue!.validate().isSuccess()) {
      hoursController.text = widget.initialValue!.value.split(':').first;
      minutesController.text = widget.initialValue!.value.split(':').last;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: context.spaces.s,
      children: [
        IntField(
          width: 58,
          controller: hoursController,
          focusNode: hoursFocusNode,
          hintText: '00',
          maxLength: 2,
          onSubmitted: (p0) {
            FocusScope.of(context).requestFocus(minutesFocusNode);
            _setTime();
          },
          onChanged: (hours) {
            _setTime();
            if (hours.length == 2) {
              FocusScope.of(context).requestFocus(minutesFocusNode);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: context.spaces.s),
          child: Text(
            ':',
            style: context.text.displayLarge.setColor(context.colors.light900),
          ),
        ),
        IntField(
          width: 58,
          controller: minutesController,
          focusNode: minutesFocusNode,
          hintText: '00',
          maxLength: 2,
          onSubmitted: (p0) {
            _setTime();
          },
          onChanged: (minutes) {
            _setTime();
          },
        ),
      ],
    );
  }
}
