import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String failureKey;
  const Failure({required this.failureKey});

  @override
  List<Object?> get props => [failureKey];
}

//general failures
class AppFailure extends Failure {
  const AppFailure({super.failureKey = "appError"});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.failureKey = "networkError"});
}

class ServerFailure extends Failure {
  const ServerFailure({super.failureKey = "serverError"});
}

class CacheFailure extends Failure {
  const CacheFailure({super.failureKey = "cacheError"});
}

class ResponseFailure extends Failure {
  const ResponseFailure({super.failureKey = "serverError"});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.failureKey = "unauthorizedError"});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({super.failureKey = "badRequestError"});
}
