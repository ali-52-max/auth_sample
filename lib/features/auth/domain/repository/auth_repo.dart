import 'package:auth_sample/features/auth/domain/entities/auth_session.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signUp({
    required String fullName,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
}
