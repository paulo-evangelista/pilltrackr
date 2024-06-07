import 'package:http/http.dart' as http;
import 'package:frontend/services/auth_interceptor.dart';

class LoginController {
  static Future<void> login(String username, String password) async {
    // Configura o interceptor para adicionar o cabeçalho de autorização
    http.Client client = http.Client();
    client.interceptors.add(AuthInterceptor(username));

    http.Response response = await client.get(Uri.parse('https://pilltrackr.cathena.io/api/client/ping'));

    print(response.body);
  }
}
