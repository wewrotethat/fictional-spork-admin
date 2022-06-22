import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/core/dio_interceptor.dart';
import 'package:fictional_spork/data/user/user_remote.dart';
import 'package:fictional_spork/data/user/user_repo.dart';

final dioProvider2 = Provider((ref) {
  return Dio()
    ..options =
        BaseOptions(baseUrl: 'https://237d-197-156-86-60.eu.ngrok.io/api')
    ..interceptors.add(ref.watch(dioInterceptorProvider));
});

final userRemoteProvider = Provider((ref) {
  return UserRemote(ref.watch(dioProvider2));
});

final userRepoProvider = Provider((ref) {
  return UserRepo(ref.watch(userRemoteProvider));
});
