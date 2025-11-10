import 'package:auth_sample/features/auth/domain/entities/auth_session.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

class SignInUseCase implements UseCase<AuthSession, SignInParams> {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSession>> call(SignInParams params) async {
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;
  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
