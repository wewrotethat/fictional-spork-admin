import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/application/auth_notifier.dart';

class DioInterceptor extends Interceptor {
  final Ref ref;

  DioInterceptor(this.ref);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final state = ref.watch(authNotifierProvider);
    final interceptedOptions = options
      ..headers.addAll(
        state.data == null
            ? {}
            : {'Authorization': 'Bearer ${state.data?.token}'},
      );
    handler.next(interceptedOptions);
  }
}

final dioInterceptorProvider = Provider((ref) {
  return DioInterceptor(ref);
});
