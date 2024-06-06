import 'package:flutter/material.dart';
import 'package:frontend/services/request_service.dart'; 
import '../../widgets/list_tile_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  late Future<http.Response> _requestsFuture;

  final RequestService _apiService = RequestService();

  final url = Uri.parse('http://10.254.19.138:8080/request/user');
  final token = 'token';
  final headers = {
    // Headers padrão ja setados no serviço de request
    '':'',
  };

  @override
  void initState() {
    super.initState();
    _requestsFuture = _apiService.fetchRequests(
      url: url,
      token: token,
      headers: headers,
    );
    debugPrint('response Data: ${_requestsFuture.toString()}');

  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requisições Feitas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFECF0F3),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFECF0F3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<http.Response>(
          future: _requestsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar requisições'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.statusCode == 200) {
                final List<dynamic> requests = json.decode(snapshot.data!.body);
                if (requests.isEmpty) {
                  return Center(child: Text('Nenhuma requisição encontrada'));
                }
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    final productNames = (request['Products'] as List<dynamic>)
                        .map((product) => product['Name'])
                        .join(', ');
                    final requestDescription = request['Description'];

                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: ListTileCustom(
                        request: request,
                        title: 'Requisição #${request['ID']}',
                        subtitle: productNames,
                        // subtitle: requestDescription,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                      'Erro ao carregar requisições: ${snapshot.data!.statusCode} ${snapshot.data!.reasonPhrase}'),
                );
              }
            } else {
              return Center(child: Text('Nenhuma requisição encontrada'));
            }
          },
        ),
      ),
    );
  }
}
