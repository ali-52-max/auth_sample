import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid, empty }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty(super.value, {this.password = ''})
    : super.dirty();

  final String password;

  ConfirmPassword copyWithPassword(String password) {
    return ConfirmPassword.dirty(value, password: password);
  }

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.invalid;
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfirmPassword &&
        other.value == value &&
        other.password == password;
  }

  @override
  int get hashCode => Object.hash(value, password);
}
