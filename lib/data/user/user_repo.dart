import 'package:fictional_spork/data/user/user_remote.dart';
import 'package:fictional_spork/core/api_exception.dart';
import 'package:fictional_spork/models/user_model.dart';

class UserRepo {
  final UserRemote _remote;

  UserRepo(this._remote);

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _remote.getUsers();
      return response
          .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<UserModel> changeVerificationStatus(
      String userId, String verificationStatus) async {
    try {
      final response = await _remote.changeVerificationStatus(
          userId, verificationStatus) as Map<String, dynamic>;
      return UserModel.fromMap(response);
    } on ApiException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
