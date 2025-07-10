import 'package:diario_de_sono/core/config/dependencies.dart';
import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

import 'settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsViewmodel _viewmodel = injector.get<SettingsViewmodel>();

  void _listener() {
    if (_viewmodel.initCommand.value.isSuccess) {
      _viewmodel.initCommand.reset();
      SnackBarDS(context, 'Alteração salva com sucesso');
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _viewmodel.saveScheduleCommand.addListener(_listener);
    _viewmodel.initCommand.execute();
  }

  @override
  void deactivate() {
    _viewmodel.saveScheduleCommand.removeListener(_listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.light800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: context.colors.base300),
        ),
        title: Text(
          'Ajustes',
          style: context.text.displaySmall.copyWith(
            color: context.colors.base300,
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: _viewmodel.initCommand,
        builder: (context, child) {
          if (_viewmodel.initCommand.value.isIdle ||
              _viewmodel.initCommand.value.isRunning) {
            return Center(
              child: CircularProgressIndicator(color: context.colors.base300),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.spaces.margin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: context.spaces.l,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: context.spaces.s,
                      left: context.spaces.s,
                      right: context.spaces.s,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.base300,
                      borderRadius: BorderRadius.circular(context.spaces.s),
                      border: Border.all(color: context.colors.base200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: context.spaces.s,
                      children: [
                        Text(
                          'Horário do lembrete:',
                          style: context.text.labelLarge.setColor(
                            context.colors.dark,
                          ),
                        ),
                        Center(
                          child: TimeBoxField(
                            initialValue: _viewmodel.scheduleTime,
                            callback: (time, end) =>
                                _viewmodel.updateScheduleCommand.execute(time),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListenableBuilder(
                    listenable: Listenable.merge([
                      _viewmodel,
                      _viewmodel.saveScheduleCommand,
                    ]),
                    builder: (context, child) {
                      return ButtonDS.full(
                        label: 'Salvar',
                        style: ButtonDSStyle.primary,
                        isLoading:
                            _viewmodel.saveScheduleCommand.value.isRunning,
                        disabled: _viewmodel.scheduleTime == null,
                        onPressed: () =>
                            _viewmodel.saveScheduleCommand.execute(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
