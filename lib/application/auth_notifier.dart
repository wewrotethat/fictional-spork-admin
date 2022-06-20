import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/data/auth/auth_repo.dart';
import 'package:fictional_spork/data/auth/providers.dart';
import 'package:fictional_spork/core/api_exception.dart';
import 'package:fictional_spork/models/auth_model.dart';

class AuthState {
  final bool isLoading;
  final AuthModel? data;
  final String? error;

  const AuthState({required this.isLoading, this.data, this.error});

  AuthState copyWith({
    bool? isLoading,
    AuthModel? data,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  const AuthState.initial()
      : isLoading = false,
        data = null,
        error = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isLoading == isLoading &&
        other.data == data &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ data.hashCode ^ error.hashCode;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo _repo;
  AuthNotifier(this._repo) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await _repo.login(email, password);
      state = state.copyWith(isLoading: false, data: response);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const AuthState.initial();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepoProvider));
});
