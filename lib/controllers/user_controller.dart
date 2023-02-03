import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/repository/user_repository.dart';
import 'package:c_masteruser/utils/encrypter.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  UserRepository userRepo = UserRepository();

  Future<UserModel?> addUser(
      String email, String name, String? description, String password,
      {int type = 1}) async {
    Response r;
    r = await userRepo.addUser(email, name, description, password, type: 1);
    Map<String, dynamic> data = jsonDecode(jsonEncode(r.data));
    UserModel umodel = UserModel.fromJson(data);
    return umodel;
  }

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

  Future<User?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");

    User? userReturn;
    if (email == null || password == null) {
      return null;
    }
    password = decrypt(password);
    userReturn = await login(email: email, password: password);
    return userReturn;
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

      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await prefs.setString("email", email);
      await prefs.setString("password", encrypt(password));
    }
    return userReturn;
  }

  Future<User?> register({String id = "", String email = "", String password = "", String nama = "", String telp = ""}) async {
    User? userReturn;
    Response r =
        await userRepo.register(id: id, email: email, password: password, name: nama, notelp: telp);
    Map<String, dynamic> data = jsonDecode(jsonEncode(r.data));
    UserModel umodel = UserModel.fromJson(data);
    if (umodel.data != null && umodel.data!.isNotEmpty) {
      userReturn = umodel.data!.first;
    }

    return userReturn;
  }
}
