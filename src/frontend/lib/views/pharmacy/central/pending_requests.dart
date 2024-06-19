import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../models/request.dart';
import '../../../services/pharmacy_request_service.dart';
import '../../../widgets/list_tile_pharmacy.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  final RequestService _requestService = RequestService();
  List<Request> _requests = [];

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    try {
      List<Request> requests = await _requestService.fetchRequests();
      setState(() {
        _requests = requests;
      });
    } catch (e) {
      print('Erro ao buscar requisições: $e');
    }
  }

  Future<void> _sendRequests() async {
    try {
      await _requestService.sendRequests(_requests);
      if (kDebugMode) {
        print('Requisições enviadas com sucesso!');
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
        title: const Text(
          'Pilltrackr',
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
        child: Column(
          children: [
            Expanded(
              child: _requests.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ReorderableListView(
                      onReorder: _onReorder,
                      children: _requests.map((request) {
                        return Card(
                          key: ValueKey(request.id),
                          child: ListTilePharmacy(
                            title: request.productName,
                            subtitle: request.status,
                          ),
                        );
                      }).toList(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _sendRequests,
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
