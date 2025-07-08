import 'package:diario_de_sono/designer_system/theme/theme.dart';
import 'package:diario_de_sono/ui/app_routes.dart';
import 'package:flutter/material.dart';

import '../../app_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => navigatorKey.currentState?.popAndPushNamed(AppRoutes.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colors.dark, context.colors.light800],
        ),
      ),
    );
  }
}
