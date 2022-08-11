/// Exception, that occurs when message is invalid.
class InvalidNameException implements Exception {
  /// Message, describing exception's explanation.
  const InvalidNameException(this.message);
  final String message;

  /// Constructor for [InvalidNameException].

  @override
  String toString() => 'InvalidNameException(message: $message)';
}
