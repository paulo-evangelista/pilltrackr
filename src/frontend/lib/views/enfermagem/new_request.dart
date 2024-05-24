import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'success_requests.dart'; // Importa a nova página

class NewRequest extends StatefulWidget {
  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final List<String> _medicines = ['Aspirina', 'Paracetamol', 'Ibuprofeno'];
  String? _selectedMedicine;
  bool _isImmediate = false;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _sendRequest() async {
    if (_selectedMedicine == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    final url = Uri.parse('http://192.168.43.120:8080/request/create'); 
    final token = 'token';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      };
    final body = json.encode({
      "productCodes": ["002"],
      "pixiesID": 2,
      "urgent": false,
      "description": "Está sem nada"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        // Simulação de ID de requisição e localização do Pyxis para o exemplo
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar requisição: ${response.statusCode} ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar requisição: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3), 
      appBar: AppBar(
        backgroundColor: Color(0xFFECF0F3), 
        title: Text(
          'Medicamentos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medicamento Faltante:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedMedicine,
              onChanged: (newValue) {
                setState(() {
                  _selectedMedicine = newValue;
                });
              },
              items: _medicines.map((medicine) {
                return DropdownMenuItem(
                  value: medicine,
                  child: Text(medicine),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                // Lógica para adicionar um novo medicamento
              },
              icon: Icon(Icons.add),
              label: Text('Adicionar medicamento'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Precisa imediatamente?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: _isImmediate,
                  onChanged: (newValue) {
                    setState(() {
                      _isImmediate = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Descrição Adicional:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _sendRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                  textStyle: TextStyle(fontSize: 15),
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
