import 'package:flutter/material.dart';

import 'package:diario_de_sono/designer_system/designer_system.dart';

class DalyDialogueWidget extends StatelessWidget {
  final String title;
  final double evolution;
  final void Function()? backFn;
  final void Function()? nextFn;
  final Widget content;
  const DalyDialogueWidget({
    super.key,
    required this.title,
    this.evolution = 0.1,
    this.backFn,
    this.nextFn,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spaces.s,
        vertical: context.spaces.m,
      ),
      margin: EdgeInsets.symmetric(horizontal: context.spaces.s),
      decoration: BoxDecoration(
        color: context.colors.light50,
        borderRadius: BorderRadius.circular(context.spaces.m),
        border: Border.all(color: context.colors.dark),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.text.displaySmall.setColor(context.colors.light900),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.spaces.m),
          content,
          Evolution(evolution: evolution, backFn: backFn, nextFn: nextFn),
        ],
      ),
    );
  }
}
