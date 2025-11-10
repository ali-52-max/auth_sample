import 'package:auth_sample/core/api/endpoints.dart';
import 'package:dio/dio.dart';
import '../../../../../core/config/env.dart';
import '../../../../../core/network/dio_error_handler.dart';
import '../../../../../core/network/dio_factory.dart';
import '../../../../../core/services/encryption_service.dart';
import '../../models/auth_session_model.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    required String userKey,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String newUserKey,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioFactory _dioFactory;
  final AesEncryptionService _encryptionService;
  final String _registrationKey = Env.registrationKey;

  AuthRemoteDataSourceImpl(this._dioFactory, this._encryptionService);

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    required String userKey,
  }) async {
    try {
      final payload = _encryptionService.encrypt(
        plainText: password,
        base64Key: userKey,
      );

      final response = await _dioFactory.post(
        EndPoints.login,
        data: {'email': email, 'payload': payload.ciphertext, 'iv': payload.iv},
      );
      return AuthSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String newUserKey,
  }) async {
    try {
      final passPayload = _encryptionService.encrypt(
        plainText: password,
        base64Key: newUserKey,
      );

      final keyPayload = _encryptionService.encrypt(
        plainText: newUserKey,
        base64Key: _registrationKey,
      );

      final response = await _dioFactory.post(
        EndPoints.register,
        data: {
          'name': name,
          'email': email,

          'keyPayload': keyPayload.ciphertext,
          'keyIv': keyPayload.iv,

          'passPayload': passPayload.ciphertext,
          'passIv': passPayload.iv,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handleDioError(e);
    }
  }
}
