import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class DioFactory {
  final SecureStorageService _storageService;
  Dio? _dio;
  Dio? _refreshDio;

  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  DioFactory(this._storageService);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = await _getDio();
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = await _getDio();
    return dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Dio> _getDio() async {
    if (_dio != null) return _dio!;

    final dio = Dio(
      BaseOptions(
        baseUrl: "https://api.yourdomain.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(_createAuthInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    _dio = dio;
    return _dio!;
  }

  Dio _getRefreshDio() {
    if (_refreshDio != null) return _refreshDio!;

    _refreshDio = Dio(
      BaseOptions(
        baseUrl: "https://api.yourdomain.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    if (kDebugMode) {
      _refreshDio!.interceptors.add(PrettyDioLogger(requestBody: true));
    }
    return _refreshDio!;
  }

  // --- Interceptor Logic ---

  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.path.contains('/auth/')) {
          return handler.next(options);
        }

        final token = await _storageService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode != 401 ||
            e.requestOptions.path.contains('/auth/refresh')) {
          return handler.next(e);
        }

        if (_isRefreshing) {
          _pendingRequests.add(e.requestOptions);
          return;
        }

        _isRefreshing = true;

        final newTokens = await _performTokenRefresh();

        if (newTokens == null) {
          _isRefreshing = false;
          _pendingRequests.clear();
          await _storageService.clearTokens();
          return handler.next(e);
        }

        await _storageService.write(
          key: 'accessToken',
          value: newTokens['accessToken']!,
        );
        if (newTokens['refreshToken'] != null) {
          await _storageService.write(
            key: 'refreshToken',
            value: newTokens['refreshToken']!,
          );
        }

        final newAccessToken = newTokens['accessToken']!;
        e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        try {
          final response = await _dio!.fetch(e.requestOptions);

          await _processPendingRequests(newAccessToken);
          _isRefreshing = false;

          return handler.resolve(response);
        } catch (retryError) {
          _isRefreshing = false;
          _pendingRequests.clear();
          return handler.next(e);
        }
      },
    );
  }

  /// Returns a map with new 'accessToken' and 'refreshToken'
  Future<Map<String, String>?> _performTokenRefresh() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) return null;

      final refreshDio = _getRefreshDio();
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        return {
          'accessToken': response.data['accessToken'],
          'refreshToken': response.data['refreshToken'],
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _processPendingRequests(String newAccessToken) async {
    final requestsToProcess = List<RequestOptions>.from(_pendingRequests);
    _pendingRequests.clear();

    for (final request in requestsToProcess) {
      try {
        request.headers['Authorization'] = 'Bearer $newAccessToken';
        await _dio!.fetch(request);
      } catch (e) {
        print('Failed to retry pending request: ${request.path}');
      }
    }
  }
}
