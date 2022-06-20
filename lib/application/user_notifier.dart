import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/data/user/providers.dart';
import 'package:fictional_spork/data/user/user_repo.dart';
import 'package:fictional_spork/core/api_exception.dart';
import 'package:fictional_spork/models/user_model.dart';

class UserState {
  final bool isLoading;
  final List<UserModel> data;
  final String? error;

  const UserState({required this.isLoading, required this.data, this.error});

  UserState copyWith({
    bool? isLoading,
    List<UserModel>? data,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  UserState.initial()
      : isLoading = false,
        data = [],
        error = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.isLoading == isLoading &&
        other.data == data &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ data.hashCode ^ error.hashCode;
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepo _repo;
  UserNotifier(this._repo) : super(UserState.initial());

  Future<void> getUsers() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await _repo.getUsers();
      state = state.copyWith(isLoading: false, data: response);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> changeVerificationStatus(
      String userId, String verificationStatus) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final response =
          await _repo.changeVerificationStatus(userId, verificationStatus);
      state = state.copyWith(
        isLoading: false,
        data: [
          for (final user in state.data)
            if (user.id == response.id) response else user
        ],
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  UserModel getUserById(String id) {
    final user = state.data.singleWhere((element) => element.id == id);
    return user;
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(ref.watch(userRepoProvider));
});
