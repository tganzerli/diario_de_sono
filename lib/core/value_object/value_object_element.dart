import 'package:result_dart/result_dart.dart';

import '../services/services.dart';

abstract class ValueObject<T extends Object> extends ValidationService {
  final T value;

  ValueObject(this.value);

  Validation validate();

  Result<S> flatValidate<S extends ValueObject>() {
    return validate() //
        .map((s) => s as S)
        .mapError((e) => e.joinException());
  }

  String? validByString() {
    return validate() //
        .mapError((e) => e.toMessage())
        .exceptionOrNull();
  }

  bool isValid() {
    return validate() //
        .pure(true)
        .getOrDefault(false);
  }

  @override
  String toString() => '$value';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueObject<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
