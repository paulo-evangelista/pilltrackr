import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String username;

  AuthInterceptor(this.username);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = '$username';
    super.onRequest(options, handler);
  }
}
