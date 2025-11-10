// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    AuthSessionModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthSessionModelToJson(AuthSessionModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'user': instance.user.toJson(),
    };
