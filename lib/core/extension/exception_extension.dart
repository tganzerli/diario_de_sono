extension ExceptionExtension on Exception {
  String toMessage() {
    return toString().replaceFirst('Exception: ', '');
  }
}
