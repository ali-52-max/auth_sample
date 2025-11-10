import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:auth_sample/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth_sample/features/auth/domain/entities/auth_session.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repo.dart';
import 'package:auth_sample/core/errors/failures.dart';

// Generated mocks
import 'sign_in_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInUseCase(mockAuthRepository);
  });

  // --- Test Data ---
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tParams = SignInParams(email: tEmail, password: tPassword);

  const tUser = User(id: '1', name: 'Test User', email: tEmail);
  const tAuthSession = AuthSession(
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    user: tUser,
  );

  test('should get auth session from the repository', () async {
    // ARRANGE
    when(
      mockAuthRepository.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => const Right(tAuthSession));

    // ACT
    final result = await useCase(tParams);

    // ASSERT
    // 1. Check that the result is what we expect
    expect(result, equals(const Right(tAuthSession)));

    // 2. VERIFY that the repository was called with the correct data
    verify(mockAuthRepository.signIn(email: tEmail, password: tPassword));

    // 3. Verify no other methods were called on the repository
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return a Failure when the repository call fails', () async {
    // ARRANGE
    when(
      mockAuthRepository.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // ACT
    final result = await useCase(tParams);

    // ASSERT
    expect(result, equals(Left(ServerFailure())));
    verify(mockAuthRepository.signIn(email: tEmail, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
