import 'package:flutter/material.dart';

class ListTilePharmacy extends StatefulWidget {
  // final Request request;

  final String title;
  final String subtitle;

  const ListTilePharmacy({
    super.key,
    required this.title,
    required this.subtitle,
    // required this.request,
  });

  @override
  _ListTilePharmacyState createState() => _ListTilePharmacyState();
}

class _ListTilePharmacyState extends State<ListTilePharmacy> {
  // late Request _request;
  late String _title;
  late String _subtitle;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _subtitle = widget.subtitle;
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Requisição $_title'),
          content: const Text('A requisição foi encaminhada para a farmácia central \nStatus:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Chat'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o modal
                // Adicionar tela de chat para levar o usuário após clicar
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SecondScreen()),
                // );
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
      title: Text(_title),
      subtitle: Text(_subtitle),
      leading: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_box_outlined)
        ],
      ),
      // title: Text(_title),
      // subtitle: Text(_subtitle),
      trailing: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.mark_chat_unread_outlined),
      ),
      onTap: () => _showModal(context),
      isThreeLine: true,
    );
  }
}