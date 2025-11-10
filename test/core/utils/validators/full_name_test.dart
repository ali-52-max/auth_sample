import 'package:flutter_test/flutter_test.dart';
import 'package:auth_sample/core/utils/validators/full_name.dart';

void main() {
  group('FullName Validator', () {
    test(
      'pure full name should be invalid because its initial value is empty',
      () {
        const fullName = FullName.pure();
        expect(fullName.isPure, isTrue); // It's pure
        expect(fullName.isValid, isFalse); // But invalid
        expect(
          fullName.error,
          FullNameValidationError.empty,
        ); // Error is 'empty'
      },
    );

    test('empty full name should be invalid and return empty error', () {
      const fullName = FullName.dirty('');
      expect(fullName.isValid, isFalse);
      expect(fullName.error, FullNameValidationError.empty);
    });

    test('name shorter than 5 chars should be invalid', () {
      const fullName = FullName.dirty('John'); // Length 4
      expect(fullName.isValid, isFalse);
      expect(fullName.error, FullNameValidationError.invalid);
    });

    test('name containing numbers should be invalid', () {
      const fullName = FullName.dirty('John Doe 123');
      expect(fullName.isValid, isFalse);
      expect(fullName.error, FullNameValidationError.invalid);
    });

    test('name containing special characters should be invalid', () {
      const fullName = FullName.dirty('John Doe!');
      expect(fullName.isValid, isFalse);
      expect(fullName.error, FullNameValidationError.invalid);
    });

    test('valid name (5 chars) should be valid', () {
      const fullName = FullName.dirty('Sarah');
      expect(fullName.isValid, isTrue);
      expect(fullName.error, isNull);
    });

    test('valid name with space should be valid', () {
      const fullName = FullName.dirty('John Doe');
      expect(fullName.isValid, isTrue);
      expect(fullName.error, isNull);
    });
  });
}
