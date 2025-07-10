import 'dart:async';

import 'package:result_dart/result_dart.dart';

extension AsyncResultExtension<S extends Object, F extends Object>
    on AsyncResultDart<S, F> {
  AsyncResultDart<W, F> flatFold<W extends Object, R extends Object>(
    FutureOr<ResultDart<W, F>> Function(S success) onSuccess,
    FutureOr<ResultDart<W, F>> Function(F error) onError,
  ) {
    return then((result) => result.fold(onSuccess, onError));
  }
}
