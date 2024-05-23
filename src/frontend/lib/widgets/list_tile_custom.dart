import 'package:flutter/material.dart';

class ListTileCustom extends StatefulWidget {
  final String title;
  final String subtitle;

  const ListTileCustom({super.key, required this.title, required this.subtitle});

  @override
  // ignore: library_private_types_in_public_api
  _ListTileCustomState createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  
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
          title: const Text('Requsição #1234'),
          content: const Text('A requisição foi encaminhada para a farmácia central \nStatus: Aguardando envio'),
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
                //Adicionar tela de chat para levar o user apos clicar  
                //Navigator.push(
                  //context
                  //MaterialPageRoute(builder: (context) => SecondScreen()),
                //);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requisições Feitas'),
        centerTitle: true,
        ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_box_outlined)
                ],
              ),
              title: Text(_title),
              subtitle: Text(_subtitle),
              trailing: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.mark_chat_unread_outlined),
              ),
              onTap: () => _showModal(context),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
