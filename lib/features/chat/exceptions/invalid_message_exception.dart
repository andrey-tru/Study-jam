/// Exception, that occurs when message is invalid.
class InvalidMessageException implements Exception {
  /// Message, describing exception's explanation.
  const InvalidMessageException(this.message);
  final String message;

  /// Constructor for [InvalidMessageException].

  @override
  String toString() => 'InvalidMessageException(message: $message)';
}
