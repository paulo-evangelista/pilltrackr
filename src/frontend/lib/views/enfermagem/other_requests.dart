import 'package:flutter/material.dart';
import 'success_requests.dart'; 

class OtherRequests extends StatefulWidget {
  @override
  _OtherRequestsState createState() => _OtherRequestsState();
}

class _OtherRequestsState extends State<OtherRequests> {
  String? selectedProblem;
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _sendRequest() async {
    if (selectedProblem == null || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    // Simulação de resposta bem-sucedida
    String requestId = '007610e1-ab06-4f28-ac4b-064b3febad7a';
    String pyxisLocation = 'MS1347 - 14º Andar';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessRequest(
          requestId: requestId,
          pyxisLocation: pyxisLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        title: Text(
          'Outros',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: DropdownButtonFormField<String>(
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
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição Adicional:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _sendRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
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
