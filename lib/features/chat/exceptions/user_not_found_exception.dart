/// Exception, that occurs when message is invalid.
class UserNotFoundException implements Exception {
  /// Message, describing exception's explanation.
  const UserNotFoundException(this.message);
  final String message;

  /// Constructor for [UserNotFoundException].

  @override
  String toString() => 'UserNotFoundException(message: $message)';
}
