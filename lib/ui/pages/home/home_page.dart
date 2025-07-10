import 'package:diario_de_sono/core/config/dependencies.dart';
import 'package:flutter/material.dart';

import '../../../designer_system/designer_system.dart';
import '../../app_routes.dart';
import '../../app_widget.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeViewmodel _viewmodel = injector.get<HomeViewmodel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewmodel.checkScheduleCommand.execute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _viewmodel.checkScheduleCommand.execute();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.light500,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(width: 40, height: 40, color: Colors.amber),
          ),
        ),
      ),
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
            ButtonDS.small(
              prefixIcon: Icons.tune_rounded,
              onPressed: () =>
                  navigatorKey.currentState?.pushNamed(AppRoutes.settings),
            ),
            ButtonDS.small(
              prefixIcon: Icons.share_outlined,
              onPressed: () =>
                  navigatorKey.currentState?.pushNamed(AppRoutes.share),
            ),
            ButtonDS.small(
              prefixIcon: Icons.add,
              onPressed: () =>
                  navigatorKey.currentState?.pushNamed(AppRoutes.dailySleepLog),
            ),
          ],
        ),
      ),
    );
  }
}
