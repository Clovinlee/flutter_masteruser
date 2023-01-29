class UserModel {
  String? message;
  List<User>? data;

  UserModel({message, data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class User {
  late int id;
  late String name;
  String? description;
  late String email;
  String? emailVerifiedAt;
  late String createdAt;
  String? updatedAt;

  User({id, name, description, email, emailVerifiedAt, createdAt, updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
