import 'package:encrypt/encrypt.dart' as enc;
import 'encrypted_payload.dart';

class AesEncryptionService {
  String generateKey() {
    final key = enc.Key.fromSecureRandom(32);
    return key.base64;
  }

  EncryptedPayload encrypt({
    required String plainText,
    required String base64Key,
  }) {
    final key = enc.Key.fromBase64(base64Key);
    final iv = enc.IV.fromSecureRandom(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return EncryptedPayload(ciphertext: encrypted.base64, iv: iv.base64);
  }

  /// Decrypts a base64 encoded string using a given key
  String decrypt({
    required String base64Encrypted,
    required String base64Iv,
    required String base64Key,
  }) {
    final key = enc.Key.fromBase64(base64Key);
    final iv = enc.IV.fromBase64(base64Iv);
    final encryptedData = enc.Encrypted.fromBase64(base64Encrypted);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final decrypted = encrypter.decrypt(encryptedData, iv: iv);
    return decrypted;
  }
}
