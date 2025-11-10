import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(id: id, name: name, email: email);
  }

  @override
  List<Object?> get props => [id, name, email];
}
