import 'package:diario_de_sono/core/config/dependencies.dart';
import 'package:diario_de_sono/core/extension/exception_extension.dart';
import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';

import 'share_viewmodel.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final ShareViewmodel _viewmodel = injector.get<ShareViewmodel>();

  void _listener() {
    if (_viewmodel.shareCommand.value is SuccessCommand) {
      Navigator.pop(context);
    }

    if (_viewmodel.shareCommand.value is FailureCommand) {
      SnackBarDS(
        context,
        _viewmodel.shareCommand.getCachedFailure()?.toMessage() ?? '',
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _viewmodel.shareCommand.addListener(_listener);
    _viewmodel.shareCommand.execute();
  }

  @override
  void dispose() {
    _viewmodel.shareCommand.removeListener(_listener);
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
      body: Center(),
    );
  }
}
