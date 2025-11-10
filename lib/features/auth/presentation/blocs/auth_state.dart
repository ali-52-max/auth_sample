import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';

import '../../domain/entities/auth_session.dart';
part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.successfulLogin(AuthSession authSession) =
      SuccessfulLogin;
  const factory AuthState.successfulRegister(User user) = SuccessfulRegister;
  const factory AuthState.error(String failureKey) = Error;
}
