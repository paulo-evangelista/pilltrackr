import 'package:flutter/material.dart';

class ListTileCustom extends StatefulWidget {
  final String title;
  final String subtitle;

  const ListTileCustom({super.key, required this.title, required this.subtitle});

  @override
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
          title: Text('Requsição #1234'),
          content: Text('A requisição foi encaminhada para farmacia central \nStatus: Aguardando Envio'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Chat'),
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
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_box_outlined)
                ],
              ),
              title: Text(_title),
              subtitle: Text(_subtitle),
              trailing: Container(
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
