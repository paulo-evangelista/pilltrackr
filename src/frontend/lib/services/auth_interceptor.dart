import 'dart:async';
import 'package:http/http.dart' as http;

class AuthInterceptor implements http.BaseClient {
  final String username;
  final http.Client _inner = http.Client();

  AuthInterceptor(this.username);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Adiciona o cabeçalho de autorização em todas as requisições
    request.headers['Authorization'] = '$username';
    return _inner.send(request);
  }
}
