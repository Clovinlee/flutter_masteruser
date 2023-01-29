import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/repository/user_repository.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

class UserController {
  Future<User?> login(
      {String id = "", String email = "", String password = ""}) async {
    User? userReturn;

    UserRepository userRepo = UserRepository();
    Response r =
        await userRepo.getUser(id: id, email: email, password: password);
    if (r.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(r.data));
      UserModel umodel = UserModel.fromJson(data);
      if (umodel.data != null && umodel.data!.isNotEmpty) {
        userReturn = umodel.data!.first;
      }
    }
    return userReturn;
  }
}
