import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

// REAL classes
import 'package:auth_sample/features/auth/presentation/blocs/auth_bloc.dart';
// Import the event and state files
import 'package:auth_sample/features/auth/presentation/blocs/auth_event.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_state.dart';
import 'package:auth_sample/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth_sample/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:auth_sample/features/auth/domain/entities/auth_session.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/core/errors/failures.dart';

// Generated mocks
import 'auth_bloc_test.mocks.dart';

class TestFailure extends Failure {
  final String key;
  const TestFailure(this.key) : super(failureKey: key);

  @override
  String get failureKey => key;

  @override
  List<Object?> get props => [key];
}

@GenerateMocks([SignInUseCase, SignUpUseCase])
void main() {
  late AuthBloc authBloc;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignUpUseCase mockSignUpUseCase;

  // --- Test Data ---
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tFullName = 'Test User';

  const tUser = User(id: '1', name: tFullName, email: tEmail);
  const tAuthSession = AuthSession(
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    user: tUser,
  );

  const tSignInParams = SignInParams(email: tEmail, password: tPassword);
  const tSignUpParams = SignUpParams(
    fullName: tFullName,
    email: tEmail,
    password: tPassword,
  );

  final tFailure = TestFailure('server-error');
  // -----------------

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    authBloc = AuthBloc(mockSignInUseCase, mockSignUpUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthState.initial()', () {
    expect(authBloc.state, equals(const AuthState.initial()));
  });

  group('SignIn Event', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, successfulLogin] when SignIn is successful',
      // ARRANGE
      setUp: () {
        when(
          mockSignInUseCase(any),
        ).thenAnswer((_) async => const Right(tAuthSession));
      },
      // ACT
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(const AuthEvent.signIn(email: tEmail, password: tPassword)),
      // ASSERT
      expect: () => [
        const AuthState.loading(),
        AuthState.successfulLogin(tAuthSession),
      ],
      // VERIFY
      verify: (_) {
        verify(mockSignInUseCase(tSignInParams)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when SignIn fails',
      // ARRANGE
      setUp: () {
        when(mockSignInUseCase(any)).thenAnswer((_) async => Left(tFailure));
      },
      // ACT
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(const AuthEvent.signIn(email: tEmail, password: tPassword)),
      // ASSERT
      expect: () => [
        const AuthState.loading(),
        AuthState.error(tFailure.failureKey),
      ],
      verify: (_) {
        verify(mockSignInUseCase(tSignInParams)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error(appError)] when SignIn throws an exception',
      // ARRANGE
      setUp: () {
        when(mockSignInUseCase(any)).thenThrow(Exception());
      },
      // ACT
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(const AuthEvent.signIn(email: tEmail, password: tPassword)),
      // ASSERT
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('appError'),
      ],
      verify: (_) {
        verify(mockSignInUseCase(tSignInParams)).called(1);
      },
    );
  });

  group('SignUp Event', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, successfulRegister] when SignUp is successful',
      // ARRANGE
      setUp: () {
        when(
          mockSignUpUseCase(any),
        ).thenAnswer((_) async => const Right(tUser));
      },
      // ACT
      build: () => authBloc,
      act: (bloc) => bloc.add(
        const AuthEvent.signUp(
          fullName: tFullName,
          email: tEmail,
          password: tPassword,
        ),
      ),
      // ASSERT
      expect: () => [
        const AuthState.loading(),
        AuthState.successfulRegister(tUser),
      ],
      verify: (_) {
        verify(mockSignUpUseCase(tSignUpParams)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when SignUp fails',
      // ARRANGE
      setUp: () {
        when(mockSignUpUseCase(any)).thenAnswer((_) async => Left(tFailure));
      },
      // ACT
      build: () => authBloc,
      act: (bloc) => bloc.add(
        const AuthEvent.signUp(
          fullName: tFullName,
          email: tEmail,
          password: tPassword,
        ),
      ),
      // ASSERT
      expect: () => [
        const AuthState.loading(),
        AuthState.error(tFailure.failureKey),
      ],
      verify: (_) {
        verify(mockSignUpUseCase(tSignUpParams)).called(1);
      },
    );
  });
}
