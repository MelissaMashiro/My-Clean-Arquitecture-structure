class NoInternetException implements Exception {
  NoInternetException({
    required this.message,
  });

  final String message;
}
