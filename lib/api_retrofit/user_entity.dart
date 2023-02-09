// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  late int id;
  late String name;
  String? description;
  late String email;
  String? emailVerifiedAt;
  late String createdAt;
  String? updatedAt;

  UserEntity(
    String description,
    String emailVerifiedAt,
    String updatedAt,
    this.id,
    this.name,
    this.email,
    this.createdAt,
  );
}
