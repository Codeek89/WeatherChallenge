class ApiException implements Exception {
  final String? message;
  final String? prefix;

  ApiException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class NoLocationFoundException extends ApiException {
  NoLocationFoundException({message}) : super(message, "Geocoding API: ");
}

class FetchDataException extends ApiException {
  FetchDataException({message})
      : super(message, "Error During Communication: ");
}
