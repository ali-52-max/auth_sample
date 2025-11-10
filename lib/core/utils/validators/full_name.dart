import 'package:formz/formz.dart';

enum FullNameValidationError { invalid, empty }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([super.value = '']) : super.dirty();

  @override
  FullNameValidationError? validator(String value) {
    if (value.isEmpty) return FullNameValidationError.empty;
    if (value.length < 5) return FullNameValidationError.invalid;
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return FullNameValidationError.invalid;
    }
    return null;
  }
}
