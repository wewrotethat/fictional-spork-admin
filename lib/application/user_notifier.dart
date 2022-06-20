import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fictional_spork/core/api_exception.dart';
import 'package:fictional_spork/data/user/providers.dart';
import 'package:fictional_spork/data/user/user_repo.dart';
import 'package:fictional_spork/models/user_model.dart';

class UserState {
  final bool isLoading;
  final bool isLoading2;
  final List<UserModel> data;
  final String? error;
  final String? error2;

  const UserState(
      {required this.isLoading,
      required this.isLoading2,
      required this.data,
      this.error2,
      this.error});

  UserState copyWith({
    bool? isLoading,
    bool? isLoading2,
    List<UserModel>? data,
    String? error,
    String? error2,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isLoading2: isLoading2 ?? this.isLoading2,
      data: data ?? this.data,
      error: error ?? this.error,
      error2: error2 ?? this.error2,
    );
  }

  UserState.initial()
      : isLoading = false,
        data = [],
        error2 = null,
        isLoading2 = false,
        error = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.isLoading == isLoading &&
        other.isLoading2 == isLoading2 &&
        listEquals(other.data, data) &&
        other.error == error &&
        other.error2 == error2;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isLoading2.hashCode ^
        data.hashCode ^
        error.hashCode ^
        error2.hashCode;
  }
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
      state = state.copyWith(isLoading2: true, error2: null);
      final response =
          await _repo.changeVerificationStatus(userId, verificationStatus);
      state = state.copyWith(
        isLoading2: false,
        data: [
          for (final user in state.data)
            if (user.id == response.id) response else user
        ],
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading2: false, error2: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isLoading2: false, error2: e.toString());
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
