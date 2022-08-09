// ignore_for_file: sort_constructors_first

class GlobalException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  GlobalException(this.message, [this.stackTrace]);

  @override
  String toString() =>
      'AuthException(message: $message, stackTrace: $stackTrace)';
}
