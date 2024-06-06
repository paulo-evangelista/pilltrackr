import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';
import 'package:http/http.dart' as http;
import '../../widgets/list_tile_custom.dart';
import 'dart:convert';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  final List<Request> _requests = [
    Request(id: '1', title: 'Requisição #1', status: 'MS1371 - Dipirona 500mg'),
    Request(id: '2', title: 'Requisição #2', status: 'MS245 - Paracetamol 750mg'),
    Request(id: '3', title: 'Requisição #3', status: 'MS789 - Amoxicilina 500mg'),
  ];

  Future<void> _sendRequests(List<Request> requests) async {
    final url = Uri.parse('https://httpbin.org/post'); // URL do serviço de mock httpbin

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requests.map((r) => r.toJson()).toList()),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Requisições enviadas com sucesso!');
        }
        if (kDebugMode) {
          print('Resposta: ${response.body}');
        }
      } else {
        if (kDebugMode) {
          print('Falha ao enviar requisições. Código: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao enviar requisições: $e');
      }
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Request item = _requests.removeAt(oldIndex);
      _requests.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilltrackr'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              onReorder: _onReorder,
              children: _requests.map((request) {
                return Card(
                  key: ValueKey(request.id),
                  child: ListTile(
                    // ignore: prefer_const_constructors
                    title: ListTileCustom(request: request, title: '', subtitle: '',),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _sendRequests(_requests),
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}
