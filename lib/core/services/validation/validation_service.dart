import 'package:result_dart/result_dart.dart';

typedef Validation<T extends Object> = ResultDart<T, List<Exception>>;

class ValidationService {
  final List<Exception> _erros = [];

  void add(Validation<dynamic> validation) {
    final erros = validation.exceptionOrNull();
    if (erros is List<Exception>) _erros.addAll(erros);
  }

  void rule({required bool conditional, required String message}) {
    if (conditional) _erros.add(Exception(message));
  }

  Validation<T> result<T extends Object>(T element) {
    final response = List<Exception>.from(_erros);
    _erros.clear();
    if (response.isEmpty) return Success(element);
    return Failure(response);
  }
}

extension ValidationExtension on List<Exception> {
  Exception joinException([String? divider]) {
    final message = map((e) => e);
    return Exception(message.join(divider ?? ' - '));
  }

  String toMessage() {
    final message = map((e) => e);
    return message.join(', ');
  }
}
