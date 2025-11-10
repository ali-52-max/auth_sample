import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:auth_sample/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repo.dart';
import 'package:auth_sample/core/errors/failures.dart';

// Generated mocks
import 'sign_in_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignUpUseCase(mockAuthRepository);
  });

  // --- Test Data ---
  const tFullName = 'Test User';
  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  const tParams = SignUpParams(
    fullName: tFullName,
    email: tEmail,
    password: tPassword,
  );

  const tUser = User(id: '1', name: tFullName, email: tEmail);

  test(
    'should sign up user and return User entity from the repository',
    () async {
      // ARRANGE
      when(
        mockAuthRepository.signUp(
          fullName: anyNamed('fullName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      // ACT
      final result = await useCase(tParams);

      // ASSERT
      // 1. Check the result
      expect(result, equals(const Right(tUser)));

      // 2. VERIFY that the repository was called with the correct data
      verify(
        mockAuthRepository.signUp(
          fullName: tFullName,
          email: tEmail,
          password: tPassword,
        ),
      );

      // 3. Verify no other methods were called
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test('should return a Failure when the repository call fails', () async {
    // ARRANGE
    when(
      mockAuthRepository.signUp(
        fullName: anyNamed('fullName'),
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // ACT
    final result = await useCase(tParams);

    // ASSERT
    expect(result, isA<Left>());
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('should have returned a failure'),
    );

    // Verify the call was still made
    verify(
      mockAuthRepository.signUp(
        fullName: tFullName,
        email: tEmail,
        password: tPassword,
      ),
    );
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
