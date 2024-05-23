import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';
import '../../widgets/list_tile_custom.dart';

class MyRequests extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyRequests();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilltrackr'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTileCustom(request: Request(id: '1', title: 'Requisição #1', status: 'MS1371 - Dipirona 500mg')),
                ListTileCustom(request: Request(id: '2', title: 'Requisição #2', status: 'MS245 - Paracetamol 750mg')),
                ListTileCustom(request: Request(id: '3', title: 'Requisição #3', status: 'MS789 - Amoxicilina 500mg')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para enviar as requisições
              },
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}
