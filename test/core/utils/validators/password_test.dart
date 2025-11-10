import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/utils/validators/password.dart';

void main() {
  group('Password Validator', () {
    test(
      'pure password should be invalid because its initial value is empty',
      () {
        const password = Password.pure();
        expect(password.isPure, isTrue); // It's pure
        expect(password.isValid, isFalse); // But invalid
        expect(
          password.error,
          PasswordValidationError.empty,
        ); // Error is 'empty'
      },
    );

    test('empty password should be invalid and return empty error', () {
      const password = Password.dirty('');
      expect(password.isValid, isFalse);
      expect(password.error, PasswordValidationError.empty);
    });

    test('password shorter than 6 chars should be invalid', () {
      const password = Password.dirty('123');
      expect(password.isValid, isFalse);
      expect(password.error, PasswordValidationError.tooShort);
    });

    test('valid password (6 chars or more) should be valid', () {
      const password = Password.dirty('123456');
      expect(password.isValid, isTrue);
      expect(password.error, isNull);
    });

    test('valid password (long) should be valid', () {
      const password = Password.dirty('a-very-long-password');
      expect(password.isValid, isTrue);
      expect(password.error, isNull);
    });
  });
}
