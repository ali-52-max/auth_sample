class AppException implements Exception {
  final dynamic originalError;
  const AppException(this.originalError);
}

// --- Specific App Exceptions ---

class ServerException extends AppException {
  const ServerException([super.originalError]);
}

class NetworkException extends AppException {
  const NetworkException([super.originalError]);
}

class CacheException extends AppException {
  const CacheException([super.originalError]);
}

class InvalidResponseException extends AppException {
  const InvalidResponseException([super.originalError]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.originalError]);
}

class BadRequestException extends AppException {
  const BadRequestException([super.originalError]);
}
