import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage;
  SecureStorageService({required this.storage});

  // ----------- Generic Storage Services -------------- //
  Future<bool> write({required String key, required String value}) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> read({required String key}) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      await storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await storage.containsKey(key: key);
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      return await storage.readAll();
    } catch (e) {
      return {};
    }
  }

  // ----------- Token Services --------------- //
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  /// Saves both tokens
  Future<bool> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final futures = <Future>[
        storage.write(key: _accessTokenKey, value: accessToken),
        storage.write(key: _refreshTokenKey, value: refreshToken),
      ];
      await Future.wait(futures);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    String? token;
    try {
      token = await storage.read(key: _accessTokenKey);
      if (token != null) {
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final token = await storage.read(key: _refreshTokenKey);
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearTokens() async {
    try {
      await Future.wait([
        storage.delete(key: _accessTokenKey),
        storage.delete(key: _refreshTokenKey),
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
