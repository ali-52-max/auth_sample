import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/features/auth/data/models/auth_session_model.dart';
import 'package:auth_sample/features/auth/data/models/user_model.dart';
import 'package:auth_sample/features/auth/domain/entities/auth_session.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
  );

  const tAuthSessionModel = AuthSessionModel(
    accessToken: 'test-access-token',
    refreshToken: 'test-refresh-token',
    tokenType: 'Bearer',
    expiresIn: 3600,
    user: tUserModel,
  );
  const tUserEntity = User(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
  );

  const tAuthSessionEntity = AuthSession(
    accessToken: 'test-access-token',
    refreshToken: 'test-refresh-token',
    user: tUserEntity,
  );

  group('AuthSessionModel', () {
    test('should be a subclass of AuthSession entity', () {
      expect(tAuthSessionModel.toEntity(), isA<AuthSession>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final jsonString = fixture('auth_session.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);

        // --- Act ---
        final result = AuthSessionModel.fromJson(jsonMap);

        // --- Assert ---
        expect(result, equals(tAuthSessionModel));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // --- Act ---
        final result = tAuthSessionModel.toJson();

        // --- Assert ---
        final expectedMap = {
          "accessToken": "test-access-token",
          "refreshToken": "test-refresh-token",
          "tokenType": "Bearer",
          "expiresIn": 3600,
          "user": {
            "id": "1",
            "email": "test@example.com",
            "name": "Test User",
            "created_at": null,
          },
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should correctly map to the AuthSession domain entity', () {
        // --- Act ---
        final result = tAuthSessionModel.toEntity();

        // --- Assert ---
        expect(result, equals(tAuthSessionEntity));
      });
    });
  });
}
