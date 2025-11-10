import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception_to_failure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/encryption_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repo.dart';
import '../datasource/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService storageService;
  final AesEncryptionService encryptionService;

  static const _userKeyStorageKey = 'user_encryption_key';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storageService,
    required this.encryptionService,
  });

  @override
  Future<Either<Failure, AuthSession>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userKey = await storageService.read(key: _userKeyStorageKey);
      if (userKey == null) {
        return Left(AppFailure(failureKey: "No encryption key found."));
      }

      // --- DEMO HACK: Comment out the failing network call ---
      // final authSessionModel = await remoteDataSource.login(
      //   email: email,
      //   password: password,
      //   userKey: userKey,
      // );

      // --- DEMO HACK: Create and save fake tokens ---
      // const fakeAccessToken = 'fake-access-token-for-demo';
      // const fakeRefreshToken = 'fake-refresh-token-for-demo';
      // await storageService.saveTokens(
      //   accessToken: fakeAccessToken,
      //   refreshToken: fakeRefreshToken,
      //);

      // // --- DEMO HACK: Return a fake AuthSession ---
      // final fakeUser = User(id: 'fake-id-123', name: 'Demo User', email: email);
      // const fakeSession = AuthSession(
      //   accessToken: fakeAccessToken,
      //   refreshToken: fakeRefreshToken,
      //   user: fakeUser,
      // );
      // return Right(fakeSession);

      final authSessionModel = await remoteDataSource.login(
        email: email,
        password: password,
        userKey: userKey,
      );
      await storageService.saveTokens(
        accessToken: authSessionModel.accessToken,
        refreshToken: authSessionModel.refreshToken,
      );
      return Right(authSessionModel.toEntity());
    } on Exception catch (e) {
      return Left(ExceptionMapper.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final newUserKey = encryptionService.generateKey();

      // --- DEMO HACK: Comment out the failing network call ---
      // final userModel = await remoteDataSource.register(
      //   name: fullName,
      //   email: email,
      //   password: password,
      //   newUserKey: newUserKey,
      // );

      // --- DEMO HACK: Save the key anyway ---
      // await storageService.write(key: _userKeyStorageKey, value: newUserKey);

      // --- DEMO HACK: Return a fake User entity ---
      // final fakeUser = User(id: 'fake-id-123', name: fullName, email: email);
      // return Right(fakeUser);

      final userModel = await remoteDataSource.register(
        name: fullName,
        email: email,
        password: password,
        newUserKey: newUserKey,
      );

      await storageService.write(key: _userKeyStorageKey, value: newUserKey);

      return Right(userModel.toEntity());
    } on Exception catch (e) {
      return Left(ExceptionMapper.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await storageService.clearTokens();
      await storageService.delete(_userKeyStorageKey);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ExceptionMapper.mapExceptionToFailure(e));
    }
  }
}
