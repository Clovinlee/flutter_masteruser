import 'package:c_masteruser/api/api_client.dart';
import 'package:dio/dio.dart';

class UserRepository {
  static String endpoint = "/users";

  Future<Response> getUser(
      {String id = "", String email = "", String password = ""}) async {
    Response r;
    Dio dio = ApiClient.getDioClient();
    Map<String, dynamic> qParam = {
      "id": id,
      "email": email,
      "password": password,
    };
    r = await dio.get(endpoint, queryParameters: qParam);
    return r;
  }
}
