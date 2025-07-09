import 'package:diario_de_sono/core/config/dependencies.dart';
import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:diario_de_sono/domain/dto/sleep_log_dto.dart';
import 'package:diario_de_sono/ui/pages/daily_sleep_log/daily_sleep_log_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';

import 'widget/daly_dialogue_widget.dart';

class DailySleepLogPage extends StatefulWidget {
  const DailySleepLogPage({super.key});

  @override
  State<DailySleepLogPage> createState() => _DailySleepLogPageState();
}

class _DailySleepLogPageState extends State<DailySleepLogPage> {
  final DailySleepLogViewmodel _viewmodel = injector
      .get<DailySleepLogViewmodel>();

  final PageController _pageController = PageController();
  int _currentPage() => _pageController.page?.toInt() ?? 0;

  final ValueNotifier<SleepLogDto> _sleepLog = ValueNotifier(SleepLogDto());

  List<Widget> _pages(SleepLogDto dto) => [
    DalyDialogueWidget(
      title: 'A que horas você foi dormir?',
      backFn: _goToBack,
      nextFn: dto.bedtimeValidate() ? _goToNext : null,
      evolution: 0.2,
      content: TimeBoxField(
        requestFocus: true,
        initialValue: dto.bedtime,
        callback: (time, end) {
          _sleepLog.value = dto.setBedtime(time);
          if (end) {
            _goToNext();
          }
        },
      ),
    ),
    DalyDialogueWidget(
      title: 'Quanto tempo você levou para adormecer?',
      backFn: _goToBack,
      nextFn: dto.sleepLatencyValidate() ? _goToNext : null,
      evolution: 0.4,
      content: TimeBoxField(
        requestFocus: true,
        initialValue: dto.sleepLatency,
        callback: (time, end) {
          _sleepLog.value = dto.setSleepLatency(time);
          if (end) {
            _goToNext();
          }
        },
      ),
    ),
    DalyDialogueWidget(
      title: 'Qual foi a duração total do seu sono?',
      backFn: _goToBack,
      nextFn: dto.sleepDurationValidate() ? _goToNext : null,
      evolution: 0.6,
      content: TimeBoxField(
        requestFocus: true,
        initialValue: dto.sleepDuration,
        callback: (time, end) {
          _sleepLog.value = dto.setSleepDuration(time);
          if (end) {
            _goToNext();
          }
        },
      ),
    ),
    DalyDialogueWidget(
      title: 'Quantas vezes você acordou durante a noite?',
      backFn: _goToBack,
      nextFn: dto.awakeningsCountValidate()
          ? () {
              _viewmodel.sendLogCommand.execute(dto);
            }
          : null,
      evolution: 0.8,
      content: NumberBoxField(
        requestFocus: true,
        initialValue: dto.awakeningsCount,
        callback: (number, end) {
          _sleepLog.value = _sleepLog.value.setAwakeningsCount(number);
          if (end) {
            _viewmodel.sendLogCommand.execute(dto);
          }
        },
      ),
    ),
  ];

  void _goToNext() {
    if (_currentPage() >= 4) return;
    _pageController.animateToPage(
      _currentPage() + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToBack() {
    if (_currentPage() == 0) {
      Navigator.pop(context);
      return;
    }
    _pageController.animateToPage(
      _currentPage() - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _listener() {
    if (_viewmodel.sendLogCommand.value is SuccessCommand) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _viewmodel.sendLogCommand.addListener(_listener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _viewmodel.sendLogCommand.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.dark.withValues(alpha: 0.7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: 250,
          child: ValueListenableBuilder<SleepLogDto>(
            valueListenable: _sleepLog,
            builder: (context, value, child) {
              return PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: _pages(value),
              );
            },
          ),
        ),
      ),
    );
  }
}
