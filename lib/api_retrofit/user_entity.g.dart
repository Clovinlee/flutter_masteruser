// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      json['description'] as String,
      json['emailVerifiedAt'] as String,
      json['updatedAt'] as String,
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
