import 'package:flutter/foundation.dart';

/// DTO, containing auth token.
///
/// May be scaled, to implement token's duration & toJson() fromJson() methods.
@immutable
class TokenDto {
  /// Token's value.
  const TokenDto({
    this.token,
    this.error,
  });
  final String? token;
  final String? error;

  /// Constructor for [TokenDto].

  @override
  String toString() {
    return 'TokenDto(token: $token, error: $error)';
  }
}
