import 'exceptions.dart';
import 'failures.dart';

class ExceptionMapper {
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is UnauthorizedException) {
      return const UnauthorizedFailure();
    }
    if (exception is BadRequestException) {
      return const BadRequestFailure();
    }
    if (exception is NetworkException) {
      return const NetworkFailure();
    }
    if (exception is ServerException) {
      return const ServerFailure();
    }
    if (exception is CacheException) {
      return const CacheFailure();
    }
    if (exception is InvalidResponseException) {
      return const ResponseFailure();
    } else {
      return const AppFailure();
    }
  }
}
