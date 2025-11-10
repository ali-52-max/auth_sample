part of 'sign_in_form_bloc.dart';

abstract class SignInFormEvent extends Equatable {
  const SignInFormEvent();

  @override
  List<Object?> get props => [];
}

class SignInEmailChanged extends SignInFormEvent {
  final String email;
  const SignInEmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class SignInPasswordChanged extends SignInFormEvent {
  final String password;
  const SignInPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class SignInFormSubmitted extends SignInFormEvent {
  const SignInFormSubmitted();
}

class ResetSubmission extends SignInFormEvent {
  const ResetSubmission();
}
