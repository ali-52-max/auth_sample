import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = SignIn;
  const factory AuthEvent.signUp({
    required String fullName,
    required String email,
    required String password,
  }) = SignUp;
}
