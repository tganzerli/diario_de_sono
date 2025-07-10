import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/usecases/sharing_sleep_logs_usecase.dart';

class ShareViewmodel extends ChangeNotifier {
  final SharingSleepLogs _sharingSleepLogs;

  ShareViewmodel(this._sharingSleepLogs);

  late final shareCommand = Command0<Unit>(_share);

  AsyncResult<Unit> _share() async {
    return _sharingSleepLogs();
  }
}
