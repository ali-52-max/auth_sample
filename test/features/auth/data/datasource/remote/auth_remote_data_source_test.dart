import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:auth_sample/features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:auth_sample/features/auth/data/models/auth_session_model.dart';
import 'package:auth_sample/features/auth/data/models/user_model.dart';
import 'package:auth_sample/core/network/dio_factory.dart';
import 'package:auth_sample/core/services/encryption_service.dart';
import 'package:auth_sample/core/services/encrypted_payload.dart';
import 'package:auth_sample/core/errors/exceptions.dart';
import 'auth_remote_data_source_test.mocks.dart';

@GenerateMocks([DioFactory, AesEncryptionService])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockDioFactory mockDioFactory;
  late MockAesEncryptionService mockEncryptionService;

  setUp(() {
    mockDioFactory = MockDioFactory();
    mockEncryptionService = MockAesEncryptionService();
    dataSource = AuthRemoteDataSourceImpl(
      mockDioFactory,
      mockEncryptionService,
    );
  });

  // Common test data (ONLY data used by ALL groups)
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tEncryptedPayload = EncryptedPayload(
    ciphertext: 'encrypted-data',
    iv: 'iv-data',
  );

  group('login', () {
    const tUserKey = 'user-key';
    final tUserModel = UserModel(id: '1', email: tEmail, name: 'Test User');
    final tUserResponseData = {'id': '1', 'email': tEmail, 'name': 'Test User'};

    final tAuthSessionModel = AuthSessionModel(
      accessToken: 'access',
      refreshToken: 'refresh',
      user: tUserModel,
    );
    final tResponseData = {
      'accessToken': 'access',
      'refreshToken': 'refresh',
      'user': tUserResponseData,
    };
    // ------------------------------------------

    test(
      'should return AuthSessionModel when the call is successful',
      () async {
        // ARRANGE
        when(
          mockEncryptionService.encrypt(
            plainText: tPassword,
            base64Key: tUserKey,
          ),
        ).thenReturn(tEncryptedPayload);

        when(mockDioFactory.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            data: tResponseData,
            statusCode: 200,
          ),
        );

        // ACT
        final result = await dataSource.login(
          email: tEmail,
          password: tPassword,
          userKey: tUserKey,
        );

        // ASSERT
        expect(result, equals(tAuthSessionModel));

        // VERIFY
        verify(
          mockEncryptionService.encrypt(
            plainText: tPassword,
            base64Key: tUserKey,
          ),
        );
        verify(
          mockDioFactory.post(
            '/auth/login',
            data: {
              'email': tEmail,
              'payload': tEncryptedPayload.ciphertext,
              'iv': tEncryptedPayload.iv,
            },
          ),
        );
      },
    );

    test('should throw ServerException when Dio throws a 500 error', () async {
      // ARRANGE
      when(
        mockEncryptionService.encrypt(
          plainText: anyNamed('plainText'),
          base64Key: anyNamed('base64Key'),
        ),
      ).thenReturn(tEncryptedPayload);

      when(mockDioFactory.post(any, data: anyNamed('data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // ACT
      final call = dataSource.login;

      // ASSERT
      expect(
        () => call(
          email: tEmail,
          password: tPassword,
          userKey: 'user-key',
        ), // Pass any key
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('register', () {
    const tName = 'Test User';
    const tNewUserKey = 'new-user-key';
    final tUserModel = UserModel(id: '123', email: tEmail, name: tName);
    final tRegisterResponseData = {'id': '123', 'email': tEmail, 'name': tName};

    final tPassPayload = EncryptedPayload(
      ciphertext: 'pass-cipher',
      iv: 'pass-iv',
    );
    final tKeyPayload = EncryptedPayload(
      ciphertext: 'key-cipher',
      iv: 'key-iv',
    );
    // ------------------------------------------

    test('should return UserModel when registration is successful', () async {
      // ARRANGE
      when(
        mockEncryptionService.encrypt(
          plainText: tPassword,
          base64Key: tNewUserKey,
        ),
      ).thenReturn(tPassPayload);

      when(
        mockEncryptionService.encrypt(
          plainText: tNewUserKey,
          base64Key: anyNamed('base64Key'),
        ),
      ).thenReturn(tKeyPayload);

      when(mockDioFactory.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/auth/register'),
          data: tRegisterResponseData,
          statusCode: 201,
        ),
      );

      // ACT
      final result = await dataSource.register(
        name: tName,
        email: tEmail,
        password: tPassword,
        newUserKey: tNewUserKey,
      );

      // ASSERT
      expect(result, equals(tUserModel));

      // VERIFY
      verify(
        mockDioFactory.post(
          '/auth/register',
          data: {
            'name': tName,
            'email': tEmail,
            'keyPayload': tKeyPayload.ciphertext,
            'keyIv': tKeyPayload.iv,
            'passPayload': tPassPayload.ciphertext,
            'passIv': tPassPayload.iv,
          },
        ),
      );
    });
  });
}
