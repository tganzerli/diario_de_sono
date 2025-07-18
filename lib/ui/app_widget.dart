import 'package:diario_de_sono/ui/pages/home/home_page.dart';
import 'package:diario_de_sono/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../designer_system/theme/theme.dart';
import 'pages/daily_sleep_log/daily_sleep_log_page.dart';
import 'pages/settings/settings_page.dart';
import 'pages/share/share_page.dart';

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
        switch (settings.name) {
          case '/home':
            return _customPageRoute(const HomePage(), transitionType: 'fade');
          case '/daily_sleep_log':
            return _customPageRoute(
              const DailySleepLogPage(),
              transitionType: 'fade',
            );
          case '/share':
            return _customPageRoute(const SharePage(), transitionType: 'fade');
          case '/settings':
            return _customPageRoute(
              const SettingsPage(),
              transitionType: 'slide',
            );
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
    fullscreenDialog: true,
    opaque: false,
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
