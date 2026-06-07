enum ExceptionType { network, auth, server, notFound, unknown }

class AppException implements Exception {
  final String message;
  final ExceptionType type;
  final String? code;

  const AppException({
    required this.message,
    required this.type,
    this.code,
  });

  @override
  String toString() => 'AppException[$type]: $message';
}
