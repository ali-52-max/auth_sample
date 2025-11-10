import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/utils/validators/confirm_password.dart'; // Adjust this path

void main() {
  group('ConfirmPassword Validator', () {
    test(
      'pure password should be invalid because its initial value is empty',
      () {
        // value='' (default), password='' (default)
        const confirmPassword = ConfirmPassword.pure();
        expect(confirmPassword.isPure, isTrue); // It's pure
        expect(confirmPassword.isValid, isFalse); // But invalid
        expect(
          confirmPassword.error,
          ConfirmPasswordValidationError.empty,
        ); // Error is 'empty'
      },
    );

    test('empty password should be invalid and return empty error', () {
      // value='', password='password123'
      const confirmPassword = ConfirmPassword.dirty(
        '',
        password: 'password123',
      );
      expect(confirmPassword.isValid, isFalse);
      expect(confirmPassword.error, ConfirmPasswordValidationError.empty);
    });

    test('mismatched passwords should be invalid', () {
      // value='123456', password='password123'
      const confirmPassword = ConfirmPassword.dirty(
        '123456',
        password: 'password123',
      );
      expect(confirmPassword.isValid, isFalse);
      expect(confirmPassword.error, ConfirmPasswordValidationError.invalid);
    });

    test('matched passwords should be valid', () {
      // value='password123', password='password123'
      const confirmPassword = ConfirmPassword.dirty(
        'password123',
        password: 'password123',
      );
      expect(confirmPassword.isValid, isTrue);
      expect(confirmPassword.error, isNull);
    });
  });
}
