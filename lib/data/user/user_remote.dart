import 'package:dio/dio.dart';
import 'package:fictional_spork/core/api_exception.dart';

class UserRemote {
  final Dio _dio;

  UserRemote(this._dio);

  Future<List<dynamic>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw ApiException(
            "Request timeout, make sure have a stable internet connection.");
      } else if (e.type == DioErrorType.other &&
          (e.error.toString().contains('Failed host lookup') ||
              e.error.toString().contains('XMLHttpRequest error'))) {
        throw ApiException('Please connect to internet and try again.');
      } else if (e.type == DioErrorType.response) {
        throw ApiException(e.response?.data["message"]);
      } else {
        throw ApiException(e.message);
      }
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> changeVerificationStatus(
      String userId, String verificationStatus) async {
    try {
      final response = await _dio.post('/admin/users/approval',
          data: {"userId": userId, "verificationStatus": verificationStatus});
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw ApiException(
            "Request timeout, make sure have a stable internet connection.");
      } else if (e.type == DioErrorType.other &&
          (e.error.toString().contains('Failed host lookup') ||
              e.error.toString().contains('XMLHttpRequest error'))) {
        throw ApiException('Please connect to internet and try again.');
      } else if (e.type == DioErrorType.response) {
        throw ApiException(e.response?.data["message"]);
      } else {
        throw ApiException(e.message);
      }
    } on Exception {
      rethrow;
    }
  }
}
