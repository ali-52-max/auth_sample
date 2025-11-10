import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/utils/validators/email.dart'; // Adjust this path if needed

void main() {
  group('Email Validator', () {
    test('pure email should be invalid because its initial value is empty', () {
      const email = Email.pure();
      // It's "pure" (user hasn't touched it)
      expect(email.isPure, isTrue);

      // But it's "invalid" because its value is ''
      expect(email.isValid, isFalse);

      // And the error is 'empty'
      expect(email.error, EmailValidationError.empty);
    });

    test('empty email should be invalid and return empty error', () {
      // Creating a 'dirty' instance automatically runs the validator
      const email = Email.dirty('');
      expect(email.isValid, isFalse);
      expect(email.error, EmailValidationError.empty);
    });

    test('malformed email (no @) should be invalid', () {
      const email = Email.dirty('test.com');
      expect(email.isValid, isFalse);
      expect(email.error, EmailValidationError.invalid);
    });

    test('malformed email (no domain) should be invalid', () {
      const email = Email.dirty('test@test');
      expect(email.isValid, isFalse);
      expect(email.error, EmailValidationError.invalid);
    });

    test('valid email should be valid and have no error', () {
      const email = Email.dirty('test@example.com');
      expect(email.isValid, isTrue);
      expect(email.error, isNull);
    });
  });
}
