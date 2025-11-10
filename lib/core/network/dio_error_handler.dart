import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

class DioErrorHandler {
  static AppException handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(e.error);

      case DioExceptionType.cancel:
        return AppException(e.error);

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return AppException(e.error);
        }
        return ServerException(e.error);

      case DioExceptionType.badCertificate:
        return ServerException(e.error);

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return NetworkException(e.error);
        } else {
          return AppException(e.error);
        }
    }
  }
}
