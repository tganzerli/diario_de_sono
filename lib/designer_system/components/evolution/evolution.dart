import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

class Evolution extends StatelessWidget {
  final void Function()? backFn;
  final void Function()? nextFn;

  /// In percentage (0 to 1)
  final double evolution;
  const Evolution({super.key, this.backFn, this.nextFn, this.evolution = 0.1});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.spaces.xs,
      children: [
        SizedBox(
          child: ButtonDS.extraSmall(
            style: ButtonDSStyle.textBlue,
            prefixIcon: Icons.arrow_back_ios,
            onPressed: backFn,
          ),
        ),
        Expanded(child: evolutionBar(evolution)),
        SizedBox(
          child: ButtonDS.small(
            style: ButtonDSStyle.outlineBlue,
            label: 'Continuar',
            disabled: nextFn == null,
            onPressed: nextFn ?? () {},
          ),
        ),
      ],
    );
  }

  Widget evolutionBar(double evolution) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: context.spaces.xs,
              decoration: BoxDecoration(
                color: context.colors.light900,
                borderRadius: BorderRadius.circular(context.spaces.l),
              ),
            ),
            Container(
              width: constraints.maxWidth * evolution,
              height: context.spaces.xs,
              decoration: BoxDecoration(
                color: context.colors.light200,
                borderRadius: BorderRadius.circular(context.spaces.l),
              ),
            ),
          ],
        );
      },
    );
  }
}
