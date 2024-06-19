import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';
import 'package:frontend/views/chat/chat.dart';

class ListTileNursery extends StatefulWidget {
  // final Request request;
  
  final String title;
  final String subtitle;
  final String item;

  const ListTileNursery({
    super.key,
    required this.title,
    required this.subtitle,
    required this.item,
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
  late String _item;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _subtitle = widget.subtitle;
    _item = widget.item;
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
                  TextSpan(text: '$_item\n', style: TextStyle(color: Colors.black,)),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
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