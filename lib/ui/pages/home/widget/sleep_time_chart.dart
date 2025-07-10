import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:diario_de_sono/domain/entities/sleep_log.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepTimeChart extends StatelessWidget {
  final List<SleepLog> sleepLogs;
  const SleepTimeChart({super.key, required this.sleepLogs});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        padding: EdgeInsets.all(context.spaces.xs),
        decoration: BoxDecoration(
          color: context.colors.light400,
          borderRadius: BorderRadius.circular(context.spaces.xs),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: context.spaces.s,
          children: <Widget>[
            Text('Tempo de sono', style: context.text.titleLarge),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BarChart(mainBarData(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    BuildContext context,
    int x,
    double y, {
    double width = 22,
    List<int> showTooltips = const [5, 7, 9],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: context.colors.light700,
          width: width,
          borderSide: BorderSide(color: context.colors.dark, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: y != 0,
            toY: 20,
            color: context.colors.dark,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(BuildContext context) {
    sleepLogs.sort((a, b) => a.day.weekday.compareTo(b.day.weekday));
    return List.generate(7, (i) {
      if (sleepLogs.length > i) {
        return makeGroupData(
          context,
          i,
          sleepLogs[i].sleepDuration.timeInMinutes.toDouble(),
        );
      } else {
        return makeGroupData(context, i, 0);
      }
    });
  }

  BarChartData mainBarData(BuildContext context) {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => getTitles(context, value, meta),
            reservedSize: 32,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => getY(context, value, meta),
            interval: 120,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(context),
      gridData: const FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 120,
      ),
    );
  }

  Widget getY(BuildContext context, double value, TitleMeta meta) {
    final style = context.text.labelMedium.setColor(context.colors.dark);
    final hours = value ~/ 60;
    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text('${hours}h', style: style),
    );
  }

  Widget getTitles(BuildContext context, double value, TitleMeta meta) {
    final style = context.text.labelMedium.setColor(context.colors.dark);
    Widget text = switch (value) {
      0 => Text('S', style: style),
      1 => Text('T', style: style),
      2 => Text('Q', style: style),
      3 => Text('Q', style: style),
      4 => Text('S', style: style),
      5 => Text('S', style: style),
      6 => Text('D', style: style),
      _ => Text('', style: style),
    };
    return SideTitleWidget(meta: meta, space: 16, child: text);
  }
}
