import 'package:flutter/material.dart';
import '../../widgets/list_tile_custom.dart';

class MyRequests extends StatelessWidget {
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 10),
              Text('Modal Title'),
            ],
          ),
          content: Row(
            children: [
              Icon(Icons.message, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(child: Text('This is the content of the modal.')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: ListTileCustom(title: 'Titulo Teste', subtitle: 'Descrição teste.'),
        // child: ElevatedButton(
        //   onPressed: () => _showModal(context),
        //   child: Text('Show Modal'),
        // ),
        
      ),
    );
  }
}
