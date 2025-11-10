import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repository/auth_repo.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class SignUpParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [fullName, email, password];
}
