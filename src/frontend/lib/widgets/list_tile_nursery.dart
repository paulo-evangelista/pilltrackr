import 'package:flutter/material.dart';
import 'package:frontend/views/chat/chat.dart';

class ListTileNursery extends StatefulWidget {
  final String title;
  final String subtitle;
  final String item;
  final String status;

  const ListTileNursery({
    super.key,
    required this.title,
    required this.subtitle,
    required this.item,
    required this.status,
  });

  @override
  _ListTileNurseryState createState() => _ListTileNurseryState();
}

class _ListTileNurseryState extends State<ListTileNursery> {
  late String _title;
  late String _subtitle;
  late String _status;
  late String _item;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _subtitle = widget.subtitle;
    _item = widget.item;
    _status = widget.status;
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$_title'),
          content: RichText(
            text: TextSpan(
              text:
                  'A Requisição foi encaminhada para a Farmácia Central \n\n',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Items: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: '$_item\n',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Status: ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: _status,
                  style: TextStyle(
                    color: _status == 'Aguardando Aprovação'
                        ? Colors.orange.shade800
                        : _status == 'Aprovado'
                            ? Colors.green
                            : _status == 'Rejeitado'
                                ? Colors.red
                                : Colors.black,
                  ),
                ),
              ],
            ),
          ),
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
    IconData _getStatusIcon() {
      switch (_status) {
        case 'Aguardando Aprovação':
          return Icons.hourglass_empty;
        case 'Aprovado':
          return Icons.check_circle_outline;
        case 'Rejeitado':
          return Icons.cancel_outlined;
        default:
          return Icons.help_outline;
      }
    }

    return ListTile(
      title: Text('$_title'),
      subtitle: Text('$_subtitle'),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(_getStatusIcon()),
        ],
      ),
      trailing: Container(
        height: double.infinity,
        child: Icon(Icons.mark_chat_unread_outlined),
      ),
      onTap: () => _showModal(context),
      isThreeLine: false,
    );
  }
}
