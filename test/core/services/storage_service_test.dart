import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:auth_sample/core/services/storage_service.dart';

// Generated mocks
import 'storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorageService service;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureStorageService(storage: mockStorage);
  });

  // --- Test Data ---
  const tKey = 'test_key';
  const tValue = 'test_value';
  const tAccessToken = 'access-token-123';
  const tRefreshToken = 'refresh-token-456';

  group('Generic Storage Services', () {
    group('write', () {
      test('should return true when write is successful', () async {
        // ARRANGE
        // Mock the 'write' method to complete successfully
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenAnswer((_) async => Future.value());

        // ACT
        final result = await service.write(key: tKey, value: tValue);

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.write(key: tKey, value: tValue));
      });

      test('should return false when write throws an exception', () async {
        // ARRANGE
        // Mock the 'write' method to throw an error
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.write(key: tKey, value: tValue);

        // ASSERT
        expect(result, isFalse);
        verify(mockStorage.write(key: tKey, value: tValue));
      });
    });

    group('read', () {
      test('should return value when read is successful', () async {
        // ARRANGE
        when(
          mockStorage.read(key: anyNamed('key')),
        ).thenAnswer((_) async => tValue);

        // ACT
        final result = await service.read(key: tKey);

        // ASSERT
        expect(result, tValue);
        verify(mockStorage.read(key: tKey));
      });

      test('should return null when read throws an exception', () async {
        // ARRANGE
        when(
          mockStorage.read(key: anyNamed('key')),
        ).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.read(key: tKey);

        // ASSERT
        expect(result, isNull);
        verify(mockStorage.read(key: tKey));
      });
    });

    group('delete', () {
      test('should return true when delete is successful', () async {
        // ARRANGE
        when(
          mockStorage.delete(key: anyNamed('key')),
        ).thenAnswer((_) async => Future.value());

        // ACT
        final result = await service.delete(tKey);

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.delete(key: tKey));
      });

      test('should return false when delete throws an exception', () async {
        // ARRANGE
        when(
          mockStorage.delete(key: anyNamed('key')),
        ).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.delete(tKey);

        // ASSERT
        expect(result, isFalse);
        verify(mockStorage.delete(key: tKey));
      });
    });

    group('deleteAll', () {
      test('should return true when deleteAll is successful', () async {
        // ARRANGE
        when(mockStorage.deleteAll()).thenAnswer((_) async => Future.value());

        // ACT
        final result = await service.deleteAll();

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.deleteAll());
      });

      test('should return false when deleteAll throws an exception', () async {
        // ARRANGE
        when(mockStorage.deleteAll()).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.deleteAll();

        // ASSERT
        expect(result, isFalse);
        verify(mockStorage.deleteAll());
      });
    });

    group('containsKey', () {
      test('should return true when key exists', () async {
        // ARRANGE
        when(
          mockStorage.containsKey(key: anyNamed('key')),
        ).thenAnswer((_) async => true);

        // ACT
        final result = await service.containsKey(tKey);

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.containsKey(key: tKey));
      });

      test('should return false when key does not exist', () async {
        // ARRANGE
        when(
          mockStorage.containsKey(key: anyNamed('key')),
        ).thenAnswer((_) async => false);

        // ACT
        final result = await service.containsKey(tKey);

        // ASSERT
        expect(result, isFalse);
        verify(mockStorage.containsKey(key: tKey));
      });

      test(
        'should return false when containsKey throws an exception',
        () async {
          // ARRANGE
          when(
            mockStorage.containsKey(key: anyNamed('key')),
          ).thenThrow(Exception('Storage error'));

          // ACT
          final result = await service.containsKey(tKey);

          // ASSERT
          expect(result, isFalse);
          verify(mockStorage.containsKey(key: tKey));
        },
      );
    });

    group('readAll', () {
      test('should return map when readAll is successful', () async {
        // ARRANGE
        final tMap = {'key1': 'val1', 'key2': 'val2'};
        when(mockStorage.readAll()).thenAnswer((_) async => tMap);

        // ACT
        final result = await service.readAll();

        // ASSERT
        expect(result, tMap);
        verify(mockStorage.readAll());
      });

      test(
        'should return empty map when readAll throws an exception',
        () async {
          // ARRANGE
          when(mockStorage.readAll()).thenThrow(Exception('Storage error'));

          // ACT
          final result = await service.readAll();

          // ASSERT
          expect(result, isEmpty);
          verify(mockStorage.readAll());
        },
      );
    });
  });

  group('Token Services', () {
    group('saveTokens', () {
      test('should return true when both writes are successful', () async {
        // ARRANGE
        when(
          mockStorage.write(key: 'accessToken', value: tAccessToken),
        ).thenAnswer((_) async => Future.value());
        when(
          mockStorage.write(key: 'refreshToken', value: tRefreshToken),
        ).thenAnswer((_) async => Future.value());

        // ACT
        final result = await service.saveTokens(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
        );

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.write(key: 'accessToken', value: tAccessToken));
        verify(mockStorage.write(key: 'refreshToken', value: tRefreshToken));
      });

      test('should return false when one of the writes fails', () async {
        // ARRANGE
        when(
          mockStorage.write(key: 'accessToken', value: tAccessToken),
        ).thenAnswer((_) async => Future.value());
        when(
          mockStorage.write(key: 'refreshToken', value: tRefreshToken),
        ).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.saveTokens(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
        );

        // ASSERT
        expect(result, isFalse);
      });
    });

    group('getAccessToken', () {
      test('should return token when read is successful', () async {
        // ARRANGE
        when(
          mockStorage.read(key: 'accessToken'),
        ).thenAnswer((_) async => tAccessToken);
        // ACT
        final result = await service.getAccessToken();
        // ASSERT
        expect(result, tAccessToken);
        verify(mockStorage.read(key: 'accessToken'));
      });

      test('should return null when read fails', () async {
        // ARRANGE
        when(
          mockStorage.read(key: 'accessToken'),
        ).thenThrow(Exception('Storage error'));
        // ACT
        final result = await service.getAccessToken();
        // ASSERT
        expect(result, isNull);
        verify(mockStorage.read(key: 'accessToken'));
      });
    });

    group('getRefreshToken', () {
      test('should return token when read is successful', () async {
        // ARRANGE
        when(
          mockStorage.read(key: 'refreshToken'),
        ).thenAnswer((_) async => tRefreshToken);
        // ACT
        final result = await service.getRefreshToken();
        // ASSERT
        expect(result, tRefreshToken);
        verify(mockStorage.read(key: 'refreshToken'));
      });

      test('should return null when read fails', () async {
        // ARRANGE
        when(
          mockStorage.read(key: 'refreshToken'),
        ).thenThrow(Exception('Storage error'));
        // ACT
        final result = await service.getRefreshToken();
        // ASSERT
        expect(result, isNull);
        verify(mockStorage.read(key: 'refreshToken'));
      });
    });

    group('clearTokens', () {
      test('should return true when both deletes are successful', () async {
        // ARRANGE
        when(
          mockStorage.delete(key: 'accessToken'),
        ).thenAnswer((_) async => Future.value());
        when(
          mockStorage.delete(key: 'refreshToken'),
        ).thenAnswer((_) async => Future.value());

        // ACT
        final result = await service.clearTokens();

        // ASSERT
        expect(result, isTrue);
        verify(mockStorage.delete(key: 'accessToken'));
        verify(mockStorage.delete(key: 'refreshToken'));
      });

      test('should return false when one of the deletes fails', () async {
        // ARRANGE
        when(
          mockStorage.delete(key: 'accessToken'),
        ).thenAnswer((_) async => Future.value());
        // Simulate the second delete failing
        when(
          mockStorage.delete(key: 'refreshToken'),
        ).thenThrow(Exception('Storage error'));

        // ACT
        final result = await service.clearTokens();

        // ASSERT
        expect(result, isFalse);
      });
    });
  });
}
