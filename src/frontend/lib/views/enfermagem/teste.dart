import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateRequestScreen extends StatefulWidget {
  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
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

    final url = Uri.parse('https://api.exemplo.com/requests'); // Substitua pelo URL da sua API
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'medicamento': _selectedMedicine,
      'imediato': _isImmediate,
      'descricao': _descriptionController.text,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Requisição enviada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar requisição: ${response.body}')),
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
      appBar: AppBar(title: Text('Requisição Medicamentos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medicamentos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Medicamento Faltante:'),
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
                border: OutlineInputBorder(),
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
            Text('Precisa imediatamente?'),
            SwitchListTile(
              value: _isImmediate,
              onChanged: (newValue) {
                setState(() {
                  _isImmediate = newValue;
                });
              },
              title: Text('Precisa imediatamente?'),
            ),
            SizedBox(height: 20),
            Text('Descrição Adicional:'),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _sendRequest,
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
