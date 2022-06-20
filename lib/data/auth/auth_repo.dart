import 'package:fictional_spork/data/auth/auth_remote.dart';
import 'package:fictional_spork/core/api_exception.dart';
import 'package:fictional_spork/models/auth_model.dart';

class AuthRepo {
  final AuthRemote _remote;

  AuthRepo(this._remote);

  Future<AuthModel> login(String email, String password) async {
    try {
      final response =
          await _remote.login(email, password) as Map<String, dynamic>;
      return AuthModel.fromMap(response);
    } on ApiException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
