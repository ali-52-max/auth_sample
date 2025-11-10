part of 'signup_form_bloc.dart';

abstract class SignupFormEvent extends Equatable {
  const SignupFormEvent();

  @override
  List<Object> get props => [];
}

class SignupFullNameChanged extends SignupFormEvent {
  final String fullName;
  const SignupFullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class SignupEmailChanged extends SignupFormEvent {
  final String email;
  const SignupEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends SignupFormEvent {
  final String password;
  const SignupPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupFormEvent {
  final String confirmPassword;
  const SignupConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignupFormSubmitted extends SignupFormEvent {
  const SignupFormSubmitted();
}

class ResetSignupSubmission extends SignupFormEvent {
  const ResetSignupSubmission();
}
