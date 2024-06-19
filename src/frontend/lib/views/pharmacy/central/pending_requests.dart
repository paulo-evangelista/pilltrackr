import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/services/pharmacy_request_service.dart';
import 'package:frontend/widgets/list_tile_pharmacy.dart';

class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  List<Map<String, dynamic>> _requests = [];
  List<int> _requestOrder = []; // Lista para armazenar a ordem dos IDs das requisições

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    try {
      var response = await dio.get('/request/getAll');
      setState(() {
        _requests = List<Map<String, dynamic>>.from(response.data);
        _requestOrder = _requests.map((request) => request['ID'] as int).toList();
      });
    } catch (e) {
      print('Erro ao buscar requisições: $e');
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      final request = _requests.removeAt(oldIndex);
      _requests.insert(newIndex, request);

      // Atualizar a ordem dos IDs
      final requestId = _requestOrder.removeAt(oldIndex);
      _requestOrder.insert(newIndex, requestId);
      print(_requestOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requisições Pendentes',
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
        child: _requests.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ReorderableListView(
                onReorder: _onReorder,
                children: _requests.map((request) {
                  var index = _requests.indexOf(request);
                  var productNames = (request['Products'] as List<dynamic>)
                      .map((product) => product['Name'] as String)
                      .join(', ');
                  return ListTile(
                    key: ValueKey(request['ID']),
                    title: Text('Requisição #${request['ID']}'),
                    subtitle: Text('$productNames - ${request['Description']}'),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
