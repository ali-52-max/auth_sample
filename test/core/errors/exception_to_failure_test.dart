import 'package:auth_sample/core/errors/exception_to_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/errors/exceptions.dart';
import 'package:auth_sample/core/errors/failures.dart';

void main() {
  group('ExceptionMapper', () {
    test('should map UnauthorizedException to UnauthorizedFailure', () {
      // Arrange
      const exception = UnauthorizedException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<UnauthorizedFailure>());
    });

    test('should map BadRequestException to BadRequestFailure', () {
      // Arrange
      const exception = BadRequestException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<BadRequestFailure>());
    });

    test('should map NetworkException to NetworkFailure', () {
      // Arrange
      const exception = NetworkException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<NetworkFailure>());
    });

    test('should map ServerException to ServerFailure', () {
      // Arrange
      const exception = ServerException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<ServerFailure>());
    });

    test('should map CacheException to CacheFailure', () {
      // Arrange
      const exception = CacheException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<CacheFailure>());
    });

    test('should map InvalidResponseException to ResponseFailure', () {
      // Arrange
      const exception = InvalidResponseException();
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<ResponseFailure>());
    });

    test('should map a generic Exception to AppFailure', () {
      // Arrange
      final exception = Exception('Something went wrong');
      // Act
      final failure = ExceptionMapper.mapExceptionToFailure(exception);
      // Assert
      expect(failure, isA<AppFailure>());
    });
  });
}
