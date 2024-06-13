import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';

class ListTileNursery extends StatefulWidget {
  // final Request request;
  
  final String title;
  final String subtitle;

  const ListTileNursery({
    super.key,
    required this.title,
    required this.subtitle,
    // required this.request,
  });

  @override
  _ListTileNurseryState createState() => _ListTileNurseryState();
}

class _ListTileNurseryState extends State<ListTileNursery> {
  // late Request _request;
  late String _title;
  late String _subtitle;
  late String _status = 'Aguardando Aprovação';

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
          title: Text('$_title'),

          content:
            RichText(
              text: TextSpan(
                text: 'A Requisição foi encaminhada para a Farmácia Central \n\n',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Items: ', style: const TextStyle(fontWeight: FontWeight.normal,)),
                  TextSpan(text: 'Itens 1 e 2 \n', style: TextStyle(color: Colors.black,)),
                  TextSpan(text: 'Status: ', style: TextStyle(color: Colors.black)),
                  TextSpan(text: _status, style: TextStyle(color: Colors.orange.shade800,)),
                  
                ],
              ),
            ), 
          // Text('A requisição foi encaminhada para a farmácia central \nStatus: $_status'),
          
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Chat'),
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
      title: Text('$_title'),
      subtitle: Text('$_subtitle'),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_box_outlined)
        ],
      ),
      // title: Text(_title),
      // subtitle: Text(_subtitle),
      trailing: Container(
        height: double.infinity,
        child: Icon(Icons.mark_chat_unread_outlined),
      ),
      onTap: () => _showModal(context),
      isThreeLine: false,
    );
  }
}