import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/validators/index.dart';

part 'sign_in_form_state.dart';
part 'sign_in_form_event.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc() : super(const SignInFormState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInFormSubmitted>(_onSubmitted);
    on<ResetSubmission>(_onResetSubmission);
  }

  void _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInFormState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email, emailHasInteracted: true));
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInFormState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password, passwordHasInteracted: true));
  }

  void _onSubmitted(SignInFormSubmitted event, Emitter<SignInFormState> emit) {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(
      state.copyWith(
        email: email,
        password: password,
        emailHasInteracted: true,
        passwordHasInteracted: true,
      ),
    );

    if (state.isValid) {
      emit(state.copyWith(submissionReady: true));
    }
  }

  void _onResetSubmission(
    ResetSubmission event,
    Emitter<SignInFormState> emit,
  ) {
    emit(state.copyWith(submissionReady: false));
  }
}
