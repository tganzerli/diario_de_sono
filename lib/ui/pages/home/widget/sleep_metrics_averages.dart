import 'package:diario_de_sono/core/value_object/of_time_vo.dart';
import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:diario_de_sono/domain/entities/sleep_log.dart';
import 'package:flutter/material.dart';

class SleepMetricsAverages extends StatelessWidget {
  final List<SleepLog> sleepLogs;
  const SleepMetricsAverages({super.key, required this.sleepLogs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.spaces.s,
      children: [
        Text('Médias de métricas de sono', style: context.text.titleLarge),
        _box(context, lable: 'Horas que foi dormir', info: _bedtimeAverage()),
        _box(
          context,
          lable: 'Tempo para adormecer',
          info: _sleepLatencyeAverage(),
          metric: 'min',
        ),
        _box(
          context,
          lable: 'Duração do sono',
          info: _sleepDurationAverage(),
          metric: 'Horas',
        ),
        _box(
          context,
          lable: 'Quantas vezes que acordou',
          info: _awakeningsCountAverage(),
        ),
      ],
    );
  }

  String _bedtimeAverage() {
    if (sleepLogs.isEmpty) return '00:00';
    final sum = sleepLogs
        .map((e) => e.bedtime.timeInMinutes)
        .reduce((value, element) => value + element);
    final int average = sum ~/ sleepLogs.length;

    return OfTime.fromMinutes(average).value;
  }

  String _sleepLatencyeAverage() {
    if (sleepLogs.isEmpty) return '00';
    final sum = sleepLogs
        .map((e) => e.sleepLatency.timeInMinutes)
        .reduce((value, element) => value + element);
    final int average = sum ~/ sleepLogs.length;

    return average.toString();
  }

  String _sleepDurationAverage() {
    if (sleepLogs.isEmpty) return '00';
    final sum = sleepLogs
        .map((e) => e.sleepDuration.timeInMinutes)
        .reduce((value, element) => value + element);
    final int average = sum ~/ sleepLogs.length;

    return OfTime.fromMinutes(average).value;
  }

  String _awakeningsCountAverage() {
    if (sleepLogs.isEmpty) return '00';
    final sum = sleepLogs
        .map((e) => e.awakeningsCount)
        .reduce((value, element) => value + element);
    final int average = sum ~/ sleepLogs.length;

    return average.toString();
  }

  Widget _box(
    BuildContext context, {
    required String lable,
    required String info,
    String? metric,
  }) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.dark700, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: context.spaces.xxs,
            children: [
              Text(
                info,
                style: context.text.displaySmall.setColor(
                  context.colors.light900,
                ),
              ),
              if (metric != null)
                Text(
                  metric,
                  style: context.text.titleLarge.setColor(
                    context.colors.light900,
                  ),
                ),
            ],
          ),
          Text(
            lable,
            style: context.text.bodyLarge.setColor(context.colors.dark),
          ),
        ],
      ),
    );
  }
}
