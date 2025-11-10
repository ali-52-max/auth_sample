import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/features/auth/data/models/user_model.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
    createdAt: '2023-10-27T10:00:00Z',
  );

  const tUserEntity = User(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
  );

  group('UserModel', () {
    test('should be a subclass of User entity', () {
      expect(tUserModel.toEntity(), isA<User>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // --- Arrange ---
        // 1. Read the JSON string from a file
        final jsonString = fixture('user.json');
        // 2. Decode it into a Map
        final Map<String, dynamic> jsonMap = json.decode(jsonString);

        // --- Act ---
        final result = UserModel.fromJson(jsonMap);

        // --- Assert ---
        expect(result, equals(tUserModel));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // --- Act ---
        final result = tUserModel.toJson();

        // --- Assert ---
        final expectedMap = {
          "id": "1",
          "name": "Test User",
          "email": "test@example.com",
          "created_at": "2023-10-27T10:00:00Z",
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should correctly map to the User domain entity', () {
        // --- Act ---
        final result = tUserModel.toEntity();

        // --- Assert ---
        expect(result, equals(tUserEntity));
      });
    });
  });
}
