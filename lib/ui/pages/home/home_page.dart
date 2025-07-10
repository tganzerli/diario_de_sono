import 'package:diario_de_sono/core/config/dependencies.dart';
import 'package:diario_de_sono/core/extension/date_time_extension.dart';
import 'package:diario_de_sono/ui/pages/home/widget/sleep_time_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../designer_system/designer_system.dart';
import '../../app_routes.dart';
import '../../app_widget.dart';
import 'home_viewmodel.dart';
import 'widget/sleep_metrics_averages.dart';

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
    _viewmodel.initScheduleCommand.execute();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: _body(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spaces.margin),
      child: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: _viewmodel,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: context.spaces.m,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Diario do Sono',
                    style: context.text.displayMedium.setColor(
                      context.colors.dark,
                    ),
                  ),
                ),
                ToggleSwitch(
                  labels: [
                    ToggleLable(label: '  7d  ', onPressed: () {}),
                    ToggleLable(label: ' 4sem ', onPressed: () {}),
                  ],
                ),
                SleepTimeChart(sleepLogs: _viewmodel.showLogs),
                SleepMetricsAverages(sleepLogs: _viewmodel.showLogs),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Container(
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: context.spaces.xxl),
      margin: EdgeInsets.all(context.spaces.xl),
      decoration: BoxDecoration(
        color: context.colors.dark,
        borderRadius: BorderRadius.circular(context.spaces.xl),
      ),
      child: ListenableBuilder(
        listenable: _viewmodel,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonDS.small(
                prefixIcon: Icons.tune_rounded,
                style: ButtonDSStyle.textWhite,
                onPressed: () =>
                    navigatorKey.currentState?.pushNamed(AppRoutes.settings),
              ),
              ButtonDS.small(
                prefixIcon: Icons.share_outlined,
                style: ButtonDSStyle.textWhite,
                disabled: !_viewmodel.sleepLogs.any((log) => !log.isSent),
                onPressed: () =>
                    navigatorKey.currentState?.pushNamed(AppRoutes.share),
              ),
              ButtonDS.small(
                style: ButtonDSStyle.textWhite,
                prefixIcon: Icons.add,
                disabled: _viewmodel.sleepLogs.any(
                  (log) => log.day.sameDay(DateTime.now()),
                ),
                onPressed: () => navigatorKey.currentState?.pushNamed(
                  AppRoutes.dailySleepLog,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
