// lib/services/request_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  Future<http.Response> sendRequest({
    required Uri url,
    required String token,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    final combinedHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      ...headers,
    };

    final response = await http.post(url, headers: combinedHeaders, body: json.encode(body));
    return response;
  }
}
