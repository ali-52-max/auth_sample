import 'package:bloc/bloc.dart';
import 'package:auth_sample/core/utils/validators/index.dart';
import 'package:equatable/equatable.dart';

part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignUpFormBloc extends Bloc<SignupFormEvent, SignupFormState> {
  SignUpFormBloc() : super(const SignupFormState()) {
    on<SignupFullNameChanged>(_onFullNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupFormSubmitted>(_onSubmitted);
    on<ResetSignupSubmission>(_onResetSubmission);
  }

  void _onFullNameChanged(
    SignupFullNameChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final fullName = FullName.dirty(event.fullName);
    final confirmPassword = state.confirmPassword.copyWithPassword(
      state.password.value,
    );

    emit(
      state.copyWith(
        fullName: fullName,
        confirmPassword: confirmPassword,
        fullNameHasInteracted: true,
      ),
    );
  }

  void _onEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email, emailHasInteracted: true));
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final password = Password.dirty(event.password);
    final confirmPassword = state.confirmPassword.copyWithPassword(
      event.password,
    );

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        passwordHasInteracted: true,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignupConfirmPasswordChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      event.confirmPassword,
      password: state.password.value,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        confirmPasswordHasInteracted: true,
      ),
    );
  }

  void _onSubmitted(SignupFormSubmitted event, Emitter<SignupFormState> emit) {
    final fullName = FullName.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      state.confirmPassword.value,
      password: state.password.value,
    );

    emit(
      state.copyWith(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        fullNameHasInteracted: true,
        emailHasInteracted: true,
        passwordHasInteracted: true,
        confirmPasswordHasInteracted: true,
      ),
    );

    if (state.isValid) {
      emit(state.copyWith(submissionReady: true));
    }
  }

  void _onResetSubmission(
    ResetSignupSubmission event,
    Emitter<SignupFormState> emit,
  ) {
    emit(state.copyWith(submissionReady: false));
  }
}
