class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Error de conexión a internet'});
}

class DataParsingException implements Exception {
  final String message;
  DataParsingException({required this.message});

  @override
  String toString() => message;
}