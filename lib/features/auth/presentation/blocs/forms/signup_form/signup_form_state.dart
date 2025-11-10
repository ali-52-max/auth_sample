part of 'signup_form_bloc.dart';

class SignupFormState extends Equatable {
  const SignupFormState({
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.submissionReady = false,
    this.fullNameHasInteracted = false,
    this.emailHasInteracted = false,
    this.passwordHasInteracted = false,
    this.confirmPasswordHasInteracted = false,
  });

  final FullName fullName;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final bool submissionReady;
  final bool fullNameHasInteracted;
  final bool emailHasInteracted;
  final bool passwordHasInteracted;
  final bool confirmPasswordHasInteracted;

  bool get isValid =>
      fullName.isValid &&
      email.isValid &&
      password.isValid &&
      confirmPassword.isValid;

  bool get shouldShowFullNameError =>
      fullNameHasInteracted && !fullName.isValid;
  bool get shouldShowEmailError => emailHasInteracted && !email.isValid;
  bool get shouldShowPasswordError =>
      passwordHasInteracted && !password.isValid;
  bool get shouldShowConfirmPasswordError =>
      confirmPasswordHasInteracted && !confirmPassword.isValid;

  SignupFormState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    bool? submissionReady,
    bool? fullNameHasInteracted,
    bool? emailHasInteracted,
    bool? passwordHasInteracted,
    bool? confirmPasswordHasInteracted,
  }) {
    return SignupFormState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submissionReady: submissionReady ?? this.submissionReady,
      fullNameHasInteracted:
          fullNameHasInteracted ?? this.fullNameHasInteracted,
      emailHasInteracted: emailHasInteracted ?? this.emailHasInteracted,
      passwordHasInteracted:
          passwordHasInteracted ?? this.passwordHasInteracted,
      confirmPasswordHasInteracted:
          confirmPasswordHasInteracted ?? this.confirmPasswordHasInteracted,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    confirmPassword,
    submissionReady,
    fullNameHasInteracted,
    emailHasInteracted,
    passwordHasInteracted,
    confirmPasswordHasInteracted,
  ];
}
