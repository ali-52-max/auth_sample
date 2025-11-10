import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_session.dart';
import 'user_model.dart';

part 'auth_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthSessionModel extends Equatable {
  final String accessToken;
  final String refreshToken;

  @JsonKey(name: 'tokenType')
  final String? tokenType;

  @JsonKey(name: 'expiresIn')
  final int? expiresIn;

  final UserModel user;

  const AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.tokenType,
    this.expiresIn,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);

  AuthSession toEntity() {
    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    tokenType,
    expiresIn,
    user,
  ];
}
