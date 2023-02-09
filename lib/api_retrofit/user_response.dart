import 'package:c_masteruser/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String? message;
  List<User>? data;

  UserResponse({required this.message, required this.data});

  static fromJson(Map<String, dynamic> map) {
    return _$UserResponseFromJson(map);
  }

  // factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
  //       message: json['message'],
  //       data: json['data'],
  //     );
}
