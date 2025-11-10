import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:auth_sample/features/auth/presentation/blocs/forms/signin_form/sign_in_form_bloc.dart';
import 'package:auth_sample/core/utils/validators/index.dart';

void main() {
  group('SignInFormBloc', () {
    late SignInFormBloc signInFormBloc;

    setUp(() {
      signInFormBloc = SignInFormBloc();
    });

    tearDown(() {
      signInFormBloc.close();
    });

    test('initial state is correct', () {
      expect(signInFormBloc.state, const SignInFormState());
    });

    blocTest<SignInFormBloc, SignInFormState>(
      'emits state with updated email and emailHasInteracted',
      build: () => signInFormBloc,
      act: (bloc) => bloc.add(const SignInEmailChanged('test@test.com')),
      expect: () => [
        const SignInFormState(
          email: Email.dirty('test@test.com'),
          emailHasInteracted: true,
        ),
      ],
    );

    blocTest<SignInFormBloc, SignInFormState>(
      'emits state with updated password and passwordHasInteracted',
      build: () => signInFormBloc,
      act: (bloc) => bloc.add(const SignInPasswordChanged('123456')),
      expect: () => [
        const SignInFormState(
          password: Password.dirty('123456'),
          passwordHasInteracted: true,
        ),
      ],
    );

    blocTest<SignInFormBloc, SignInFormState>(
      'emits state with dirty fields and interacts, but not submissionReady, when form is invalid',
      build: () => signInFormBloc, // Starts with pure, empty fields
      act: (bloc) => bloc.add(const SignInFormSubmitted()),
      expect: () => [
        const SignInFormState(
          email: Email.dirty(''), // Re-validated as dirty
          password: Password.dirty(''), // Re-validated as dirty
          emailHasInteracted: true, // Interaction forced
          passwordHasInteracted: true, // Interaction forced
        ),
      ],
    );

    blocTest<SignInFormBloc, SignInFormState>(
      'emits state with submissionReady=true when form is valid',
      // Seed the BLoC with valid data first
      seed: () => const SignInFormState(
        email: Email.dirty('valid@email.com'),
        password: Password.dirty('validpass'),
      ),
      build: () => signInFormBloc,
      act: (bloc) => bloc.add(const SignInFormSubmitted()),
      expect: () => [
        const SignInFormState(
          email: Email.dirty('valid@email.com'),
          password: Password.dirty('validpass'),
          emailHasInteracted: true,
          passwordHasInteracted: true,
        ),
        const SignInFormState(
          email: Email.dirty('valid@email.com'),
          password: Password.dirty('validpass'),
          emailHasInteracted: true,
          passwordHasInteracted: true,
          submissionReady: true,
        ),
      ],
    );

    blocTest<SignInFormBloc, SignInFormState>(
      'emits state with submissionReady=false on ResetSubmission',
      // Seed the BLoC with submissionReady = true
      seed: () => const SignInFormState(submissionReady: true),
      build: () => signInFormBloc,
      act: (bloc) => bloc.add(const ResetSubmission()),
      expect: () => [
        // It should reset to false, but keep other state
        const SignInFormState(submissionReady: false),
      ],
    );
  });
}
