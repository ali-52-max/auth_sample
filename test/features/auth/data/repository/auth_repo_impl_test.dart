import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:auth_sample/features/auth/data/repository/auth_repo_impl.dart';
import 'package:auth_sample/features/auth/data/models/auth_session_model.dart';
import 'package:auth_sample/features/auth/data/models/user_model.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/core/errors/failures.dart';
import 'package:auth_sample/core/errors/exceptions.dart';
import 'package:auth_sample/features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:auth_sample/core/services/storage_service.dart';
import 'package:auth_sample/core/services/encryption_service.dart';

// Generated mocks
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([
  AuthRemoteDataSource,
  SecureStorageService,
  AesEncryptionService,
])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;
  late MockSecureStorageService mockStorageService;
  late MockAesEncryptionService mockEncryptionService;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    mockStorageService = MockSecureStorageService();
    mockEncryptionService = MockAesEncryptionService();

    repository = AuthRepositoryImpl(
      remoteDataSource: mockDataSource,
      storageService: mockStorageService,
      encryptionService: mockEncryptionService,
    );
  });

  group('signIn', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tUserKey = 'my-secret-key';
    const tAccessToken = 'my-access-token';
    const tRefreshToken = 'my-refresh-token';

    final tUserModel = UserModel(id: '1', email: tEmail, name: 'Test User');
    final tAuthSessionModel = AuthSessionModel(
      accessToken: tAccessToken,
      refreshToken: tRefreshToken,
      user: tUserModel,
    );
    final tAuthSessionEntity = tAuthSessionModel.toEntity();

    test('should return AuthSession when signIn is successful', () async {
      // ARRANGE
      when(
        mockStorageService.read(key: anyNamed('key')),
      ).thenAnswer((_) async => tUserKey);

      when(
        mockDataSource.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
          userKey: anyNamed('userKey'),
        ),
      ).thenAnswer((_) async => tAuthSessionModel);

      when(
        mockStorageService.saveTokens(
          accessToken: anyNamed('accessToken'),
          refreshToken: anyNamed('refreshToken'),
        ),
      ).thenAnswer((_) async => true);

      // ACT
      final result = await repository.signIn(
        email: tEmail,
        password: tPassword,
      );

      // ASSERT
      expect(result, equals(Right(tAuthSessionEntity)));

      // VERIFY
      verify(mockStorageService.read(key: 'user_encryption_key'));
      verify(
        mockDataSource.login(
          email: tEmail,
          password: tPassword,
          userKey: tUserKey,
        ),
      );
      verify(
        mockStorageService.saveTokens(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
        ),
      );
      verifyNoMoreInteractions(mockDataSource);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
      'should return NetworkFailure when a NetworkException is thrown',
      () async {
        // ARRANGE
        when(
          mockStorageService.read(key: anyNamed('key')),
        ).thenAnswer((_) async => tUserKey);

        when(
          mockDataSource.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
            userKey: anyNamed('userKey'),
          ),
        ).thenThrow(const NetworkException());

        // ACT
        final result = await repository.signIn(
          email: tEmail,
          password: tPassword,
        );
        // ASSERT
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (_) => fail('should have returned a failure'),
        );

        // VERIFY
        verify(mockStorageService.read(key: 'user_encryption_key'));
        verify(
          mockDataSource.login(
            email: tEmail,
            password: tPassword,
            userKey: tUserKey,
          ),
        );
        verifyNever(
          mockStorageService.saveTokens(
            accessToken: anyNamed('accessToken'),
            refreshToken: anyNamed('refreshToken'),
          ),
        );
      },
    );

    test('should return AppFailure when no userKey is found', () async {
      // ARRANGE
      when(
        mockStorageService.read(key: anyNamed('key')),
      ).thenAnswer((_) async => null);

      // ACT
      final result = await repository.signIn(
        email: tEmail,
        password: tPassword,
      );

      // ASSERT
      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<AppFailure>()),
        (_) => fail('should have returned a failure'),
      );

      // VERIFY
      verify(mockStorageService.read(key: 'user_encryption_key'));
      verifyNoMoreInteractions(mockStorageService);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('signUp', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tNewUserKey = 'a-brand-new-key';

    final tUserModel = UserModel(id: '1', name: tName, email: tEmail);
    final tUserEntity = User(id: '1', name: tName, email: tEmail);

    test('should return User entity when registration is successful', () async {
      // ARRANGE
      when(mockEncryptionService.generateKey()).thenReturn(tNewUserKey);

      when(
        mockDataSource.register(
          name: tName,
          email: tEmail,
          password: tPassword,
          newUserKey: tNewUserKey,
        ),
      ).thenAnswer((_) async => tUserModel);

      when(
        mockStorageService.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ),
      ).thenAnswer((_) async => true);

      // ACT
      final result = await repository.signUp(
        fullName: tName,
        email: tEmail,
        password: tPassword,
      );

      // ASSERT
      expect(result, equals(Right(tUserEntity)));

      // VERIFY
      verify(mockEncryptionService.generateKey());
      verify(
        mockDataSource.register(
          name: tName,
          email: tEmail,
          password: tPassword,
          newUserKey: tNewUserKey,
        ),
      );
      verify(
        mockStorageService.write(
          key: 'user_encryption_key',
          value: tNewUserKey,
        ),
      );
      verifyNoMoreInteractions(mockDataSource);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
      'should return Failure when data source throws an exception',
      () async {
        // ARRANGE
        when(mockEncryptionService.generateKey()).thenReturn(tNewUserKey);

        when(
          mockDataSource.register(
            name: anyNamed('name'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            newUserKey: anyNamed('newUserKey'),
          ),
        ).thenThrow(const ServerException());

        // ACT
        final result = await repository.signUp(
          fullName: tName,
          email: tEmail,
          password: tPassword,
        );

        // ASSERT
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('should have returned a failure'),
        );

        // VERIFY
        verify(mockEncryptionService.generateKey());
        verifyNever(
          mockStorageService.write(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        );
      },
    );
  });

  group('logout', () {
    test('should return Right(null) when logout is successful', () async {
      // ARRANGE
      when(mockStorageService.clearTokens()).thenAnswer((_) async => true);
      when(mockStorageService.delete(any)).thenAnswer((_) async => true);

      // ACT
      final result = await repository.logout();

      // ASSERT
      expect(result, equals(const Right(null)));

      // VERIFY
      verify(mockStorageService.clearTokens());
      verify(mockStorageService.delete('user_encryption_key'));
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
      'should return CacheFailure when storageService throws an exception',
      () async {
        // ARRANGE
        when(
          mockStorageService.clearTokens(),
        ).thenThrow(const CacheException());

        // ACT
        final result = await repository.logout();

        // ASSERT
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('should have returned a failure'),
        );

        // VERIFY
        verify(mockStorageService.clearTokens());
        verifyNever(mockStorageService.delete(any));
      },
    );
  });
}
