part of 'sign_in_form_bloc.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.submissionReady = false,
    this.emailHasInteracted = false,
    this.passwordHasInteracted = false,
  });

  final Email email;
  final Password password;
  final bool submissionReady;
  final bool emailHasInteracted;
  final bool passwordHasInteracted;

  bool get isValid => email.isValid && password.isValid;

  bool get shouldShowEmailError => emailHasInteracted && !email.isValid;
  bool get shouldShowPasswordError =>
      passwordHasInteracted && !password.isValid;

  SignInFormState copyWith({
    Email? email,
    Password? password,
    bool? submissionReady,
    bool? emailHasInteracted,
    bool? passwordHasInteracted,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailHasInteracted: emailHasInteracted ?? this.emailHasInteracted,
      passwordHasInteracted:
          passwordHasInteracted ?? this.passwordHasInteracted,
      submissionReady: submissionReady ?? this.submissionReady,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    submissionReady,
    emailHasInteracted,
    passwordHasInteracted,
  ];
}
