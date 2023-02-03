// ignore_for_file: non_constant_identifier_names

import 'package:c_masteruser/api/api_client.dart';
import 'package:dio/dio.dart';

class UserRepository {
  static String endpoint = "/users";
  static String endpoint_adduser = "/adduser";

  Future<Response> addUser(
      String email, String name, String? description, String password,
      {int type = 1}) async {
    Response r;
    Dio dio = ApiClient.getDioClient();
    Map<String, dynamic> qData = {
      "email": email,
      "name": name,
      "description": description,
      "password": password,
      "type": type,
    };
    r = await dio.post(endpoint_adduser, data: qData);
    return r;
  }

  Future<Response> getUser(
      {String id = "",
      String email = "",
      String password = "",
      String type = ""}) async {
    Response r;
    Dio dio = ApiClient.getDioClient();
    Map<String, dynamic> qParam = {
      "id": id,
      "email": email,
      "type": type,
      "password": password,
    };
    r = await dio.get(endpoint, queryParameters: qParam);
    return r;
  }

  Future<Response> register({String id = "", String email = "", String password = "", String name = "", String notelp = ""}) async {
    Response r;
    Dio dio = ApiClient.getDioClient();
    Map<String, dynamic> qParam = {
      "id": id,
      "email": email,
      "password": password,
      "name": name,
      "notelp": notelp,
      "type": 1,
    };

    r = await dio.post(endpoint_adduser, queryParameters: qParam);
    return r;
  }
}
