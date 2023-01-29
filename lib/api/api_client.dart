import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static Dio? _dioClient;

  static Dio getDioClient() {
    if (ApiClient._dioClient == null) {
      // Dio Base Option
      BaseOptions option = BaseOptions(
          baseUrl: dotenv.env["API_URL"]!,
          headers: {
            "Authorization": dotenv.env["APP_KEY"],
            "Content-Type": "application/json",
          },
          validateStatus: ((status) {
            if (status == 200) {
              return true;
            }
            return false;
          }));
      //
      _dioClient = Dio(option);
      _dioClient!.interceptors.add(DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ));
    }
    return _dioClient!;
  }
}
