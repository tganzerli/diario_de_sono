import 'package:flutter/material.dart';

import '../../../designer_system/designer_system.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.light500,
      bottomNavigationBar: Container(
        height: 58,
        padding: EdgeInsets.symmetric(horizontal: context.spaces.xxl),
        margin: EdgeInsets.all(context.spaces.xl),
        decoration: BoxDecoration(
          color: context.colors.dark,
          borderRadius: BorderRadius.circular(context.spaces.xl),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonDS(
              icon: Icons.tune_rounded,
              color: context.colors.base50,
              onPressed: () {
                print('ajustes');
              },
            ),
            IconButtonDS(
              icon: Icons.share_outlined,
              color: context.colors.base50,
              onPressed: () {
                print('compartilhar');
              },
            ),
            IconButtonDS(
              icon: Icons.add,
              color: context.colors.base50,
              onPressed: () {
                print('Adicionar sono');
              },
            ),
          ],
        ),
      ),
    );
  }
}
