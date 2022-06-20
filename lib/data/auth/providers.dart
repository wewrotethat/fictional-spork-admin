import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/data/auth/auth_remote.dart';
import 'package:fictional_spork/data/auth/auth_repo.dart';

final dioProvider = Provider((ref) {
  return Dio()
    ..options = BaseOptions(
        baseUrl: 'https://fictional-spork-server.herokuapp.com/api');
});

final authRemoteProvider = Provider((ref) {
  return AuthRemote(ref.watch(dioProvider));
});

final authRepoProvider = Provider((ref) {
  return AuthRepo(ref.watch(authRemoteProvider));
});
