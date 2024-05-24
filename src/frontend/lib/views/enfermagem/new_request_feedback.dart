import 'package:flutter/material.dart';

class NewRequestFeedback extends StatelessWidget {
  final String requestId;

  const NewRequestFeedback({Key? key, required this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Requisição Feita Medicamentos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A requisição',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              requestId,
              style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'foi feita com sucesso!',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 24),
            Text(
              'Deseja acompanhar suas requisições?',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view-requests');
                },
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
