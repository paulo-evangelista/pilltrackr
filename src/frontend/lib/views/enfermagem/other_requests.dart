import 'package:flutter/material.dart';

class OtherRequests extends StatefulWidget {
  @override
  _OtherRequestsState createState() => _OtherRequestsState();
}

class _OtherRequestsState extends State<OtherRequests> {
  String? selectedProblem;
  final TextEditingController descriptionController = TextEditingController();

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Enviado com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title: Text('Outros'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Problema Recorrente:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedProblem,
              items: <String>['Problema 1', 'Problema 2', 'Problema 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedProblem = newValue;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição Adicional:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessMessage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}