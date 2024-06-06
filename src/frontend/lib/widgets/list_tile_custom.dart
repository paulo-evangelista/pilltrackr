import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';

class ListTileCustom extends StatelessWidget {
  final Request request;

  const ListTileCustom({super.key, required this.request});

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Requisição ${request.id}'),
          content: Text('A requisição foi encaminhada para a farmácia central \nStatus: ${request.status}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(request.title),
      subtitle: Text(request.status),
      onTap: () => _showModal(context),
      isThreeLine: true,
    );
  }
}
