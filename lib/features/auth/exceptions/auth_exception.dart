import 'package:flutter/foundation.dart';

@immutable
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException(message: $message)';
}
