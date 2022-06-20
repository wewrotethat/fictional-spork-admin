import 'package:dio/dio.dart';
import 'package:fictional_spork/core/api_exception.dart';

class AuthRemote {
  final Dio _dio;

  AuthRemote(this._dio);

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio
          .post('/auth', data: {"email": email, "password": password});
      if (response.data["success"] == true) {
        return response.data;
      } else {
        throw ApiException("Wrong Credentials");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw ApiException(
            "Request timeout, make sure have a stable internet connection.");
      } else if ((e.type == DioErrorType.other ||
              e.type == DioErrorType.response) &&
          (e.error.toString().contains('Failed host lookup') ||
              e.error.toString().contains('XMLHttpRequest error'))) {
        throw ApiException('Please connect to internet and try again.');
      } else {
        print(e.type);
        throw ApiException(e.message);
      }
    } on Exception {
      rethrow;
    }
  }
}
