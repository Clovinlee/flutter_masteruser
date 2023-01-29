import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/repository/user_repository.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

class UserController {
  UserRepository userRepo = UserRepository();

  Future<List<User>?> fetchUsers(
      {String id = "", String email = "", String password = ""}) async {
    List<User>? listUsers;

    Response r =
        await userRepo.getUser(id: id, email: email, password: password);
    Map<String, dynamic> data = jsonDecode(jsonEncode(r.data));
    UserModel umodel = UserModel.fromJson(data);
    listUsers = umodel.data;
    return listUsers;
  }

  Future<User?> login(
      {String id = "", String email = "", String password = ""}) async {
    User? userReturn;

    Response r =
        await userRepo.getUser(id: id, email: email, password: password);
    Map<String, dynamic> data = jsonDecode(jsonEncode(r.data));
    UserModel umodel = UserModel.fromJson(data);
    if (umodel.data != null && umodel.data!.isNotEmpty) {
      userReturn = umodel.data!.first;
    }
    return userReturn;
  }
}
