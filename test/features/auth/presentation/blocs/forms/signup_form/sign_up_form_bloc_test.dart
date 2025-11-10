import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:auth_sample/features/auth/presentation/blocs/forms/signup_form/signup_form_bloc.dart';
import 'package:auth_sample/core/utils/validators/index.dart';

void main() {
  group('SignUpFormBloc', () {
    late SignUpFormBloc signUpFormBloc;

    setUp(() {
      signUpFormBloc = SignUpFormBloc();
    });

    tearDown(() {
      signUpFormBloc.close();
    });

    test('initial state is correct', () {
      expect(signUpFormBloc.state, const SignupFormState());
    });

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with updated fullName, confirmPassword, and interacted',
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupFullNameChanged('Test User')),
      expect: () => [
        const SignupFormState(
          fullName: FullName.dirty('Test User'),
          confirmPassword: ConfirmPassword.dirty('', password: ''),
          fullNameHasInteracted: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with updated email and interacted',
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupEmailChanged('test@test.com')),
      expect: () => [
        const SignupFormState(
          email: Email.dirty('test@test.com'),
          emailHasInteracted: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with updated password, confirmPassword, and interacted',
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupPasswordChanged('pass123')),
      expect: () => [
        const SignupFormState(
          password: Password.dirty('pass123'),
          confirmPassword: ConfirmPassword.dirty('', password: 'pass123'),
          passwordHasInteracted: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with updated confirmPassword and interacted',
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupConfirmPasswordChanged('pass123')),
      expect: () => [
        const SignupFormState(
          confirmPassword: ConfirmPassword.dirty('pass123', password: ''),
          confirmPasswordHasInteracted: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with all fields dirty and interacted on invalid submission',
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupFormSubmitted()),
      expect: () => [
        const SignupFormState(
          fullName: FullName.dirty(''),
          email: Email.dirty(''),
          password: Password.dirty(''),
          confirmPassword: ConfirmPassword.dirty('', password: ''),
          fullNameHasInteracted: true,
          emailHasInteracted: true,
          passwordHasInteracted: true,
          confirmPasswordHasInteracted: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with submissionReady=true when form is valid',
      // Seed the BLoC with a valid state
      seed: () => const SignupFormState(
        fullName: FullName.dirty('Valid Name'),
        email: Email.dirty('valid@email.com'),
        password: Password.dirty('pass123'),
        confirmPassword: ConfirmPassword.dirty('pass123', password: 'pass123'),
      ),
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const SignupFormSubmitted()),
      // Expect two states:
      expect: () => [
        const SignupFormState(
          fullName: FullName.dirty('Valid Name'),
          email: Email.dirty('valid@email.com'),
          password: Password.dirty('pass123'),
          confirmPassword: ConfirmPassword.dirty(
            'pass123',
            password: 'pass123',
          ),
          fullNameHasInteracted: true,
          emailHasInteracted: true,
          passwordHasInteracted: true,
          confirmPasswordHasInteracted: true,
        ),
        const SignupFormState(
          fullName: FullName.dirty('Valid Name'),
          email: Email.dirty('valid@email.com'),
          password: Password.dirty('pass123'),
          confirmPassword: ConfirmPassword.dirty(
            'pass123',
            password: 'pass123',
          ),
          fullNameHasInteracted: true,
          emailHasInteracted: true,
          passwordHasInteracted: true,
          confirmPasswordHasInteracted: true,
          submissionReady: true,
        ),
      ],
    );

    blocTest<SignUpFormBloc, SignupFormState>(
      'emits state with submissionReady=false on ResetSubmission',
      // Seed the BLoC with submissionReady = true
      seed: () => const SignupFormState(submissionReady: true),
      build: () => signUpFormBloc,
      act: (bloc) => bloc.add(const ResetSignupSubmission()),
      expect: () => [
        // It should reset to false, but keep other state
        const SignupFormState(submissionReady: false),
      ],
    );
  });
}
