import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/services/encryption_service.dart';
import 'package:auth_sample/core/services/encrypted_payload.dart';

void main() {
  late AesEncryptionService encryptionService;

  setUp(() {
    encryptionService = AesEncryptionService();
  });

  group('AesEncryptionService', () {
    group('generateKey', () {
      test('should generate a valid 32-byte key encoded in base64', () {
        // Act
        final key = encryptionService.generateKey();

        // Assert
        expect(key, isA<String>());
        expect(key, isNotEmpty);

        // Check that it's valid base64 and has the correct decoded length
        final decodedKey = base64.decode(key);
        expect(decodedKey.length, 32);
      });
    });

    group('encrypt / decrypt (round-trip)', () {
      test(
        'should correctly decrypt a value that was encrypted by the service',
        () {
          // Arrange
          const plainText = 'This is my secret message!';
          final key = encryptionService.generateKey();

          // Act
          // 1. Encrypt the data
          final EncryptedPayload payload = encryptionService.encrypt(
            plainText: plainText,
            base64Key: key,
          );

          // 2. Decrypt the data
          final decryptedText = encryptionService.decrypt(
            base64Encrypted: payload.ciphertext,
            base64Iv: payload.iv,
            base64Key: key,
          );

          // Assert
          // 3. Check if the original matches the result
          expect(decryptedText, equals(plainText));

          // 4. (Optional) Sanity check that the encrypted text is not the same
          expect(payload.ciphertext, isNot(equals(plainText)));
        },
      );
    });
  });
}
