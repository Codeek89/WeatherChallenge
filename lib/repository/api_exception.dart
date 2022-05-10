/// Base class used to create custom exceptions
class ApiException implements Exception {
  final String? message;
  final String? prefix;

  ApiException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix$message";
  }
}

/// Exception used to deal with missing locations while searching.
class NoLocationFoundException extends ApiException {
  NoLocationFoundException({message}) : super(message, "Geocoding API: ");
}

/// Exception used when having trouble while connecting to the internet.
class FetchDataException extends ApiException {
  FetchDataException({message})
      : super(message, "Error During Communication: ");
}
