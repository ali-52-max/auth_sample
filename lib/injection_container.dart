import 'package:auth_sample/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth_sample/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/blocs/forms/signIn_form/sign_in_form_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_factory.dart';
import 'core/services/encryption_service.dart';
import 'core/services/storage_service.dart';
import 'features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repo_impl.dart';
import 'features/auth/domain/repository/auth_repo.dart';
import 'features/auth/presentation/blocs/forms/signup_form/signup_form_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(storage: getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton<DioFactory>(
    () => DioFactory(getIt<SecureStorageService>()),
  );
  getIt.registerLazySingleton<AesEncryptionService>(
    () => AesEncryptionService(),
  );

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt<DioFactory>(),
      getIt<AesEncryptionService>(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      storageService: getIt<SecureStorageService>(),
      encryptionService: getIt<AesEncryptionService>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );

  // Cubits / Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<SignInUseCase>(), getIt<SignUpUseCase>()),
  );
  getIt.registerFactory<SignInFormBloc>(() => SignInFormBloc());
  getIt.registerFactory<SignUpFormBloc>(() => SignUpFormBloc());
}
