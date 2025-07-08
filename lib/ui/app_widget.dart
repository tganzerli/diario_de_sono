import 'package:diario_de_sono/ui/pages/home/home_page.dart';
import 'package:diario_de_sono/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../designer_system/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/home':
            return _customPageRoute(const HomePage(), transitionType: 'fade');
          default:
            return _customPageRoute(const SplashPage(), transitionType: 'fade');
        }
      },
    );
  }
}

PageRouteBuilder _customPageRoute(
  Widget page, {
  String transitionType = 'slide',
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case 'fade':
          return FadeTransition(opacity: animation, child: child);
        case 'scale':
          return ScaleTransition(scale: animation, child: child);
        case 'slide':
        default:
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  );
}
