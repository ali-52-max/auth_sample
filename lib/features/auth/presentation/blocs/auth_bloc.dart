import 'package:auth_sample/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_event.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_state.dart';
import 'package:bloc/bloc.dart';
import '../../domain/usecases/sign_up_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  AuthBloc(this._signInUseCase, this._signUpUseCase)
    : super(AuthState.initial()) {
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
  }

  void _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    try {
      final authSession = await _signInUseCase.call(
        SignInParams(email: event.email, password: event.password),
      );
      authSession.fold(
        (failure) => emit(AuthState.error(failure.failureKey)),
        (authSession) => emit(AuthState.successfulLogin(authSession)),
      );
    } catch (e) {
      emit(AuthState.error('appError'));
    }
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    try {
      final user = await _signUpUseCase.call(
        SignUpParams(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        ),
      );
      user.fold(
        (failure) => emit(AuthState.error(failure.failureKey)),
        (user) => emit(AuthState.successfulRegister(user)),
      );
    } catch (e) {
      emit(AuthState.error('appError'));
    }
  }
}
