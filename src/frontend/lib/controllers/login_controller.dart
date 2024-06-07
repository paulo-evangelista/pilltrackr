import 'package:dio/dio.dart';

class LoginController {
  static Future<void> login(String username, String password) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(username));
    Response response = await dio.get('https://pilltrackr.cathena.io/api/client/ping');
    print(response.data);
  }
}
