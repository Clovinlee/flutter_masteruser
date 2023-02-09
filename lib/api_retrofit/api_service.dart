import 'package:c_masteruser/api/api_client.dart';
import 'package:c_masteruser/api_retrofit/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part "api_service.g.dart";

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET("/users")
  Future<UserResponse> getUserData(
    @Query("id") String id,
  );
}
