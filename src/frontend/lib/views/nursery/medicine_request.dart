import 'package:flutter/material.dart';
import 'package:frontend/views/nursery/feedback_request.dart';
import 'dart:convert';


class MedicineRequest extends StatefulWidget {
  @override
  _MedicineRequest createState() => _MedicineRequest();
}

class _MedicineRequest extends State<MedicineRequest> {
  final List<String> _medicines = ['Aspirina', 'Paracetamol', 'Ibuprofeno'];
  String? _selectedMedicine;
  late String _productCode;
  bool _isImmediate = false;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _sendRequest() async {
    String requestId = 'MR-0042F';
    String pyxisLocation = 'MS1347 - 14º Andar';
    Navigator.pushNamed(
      context,
      '/feedbackRequest',
      arguments: {'requestId': requestId, 'pyxisLocation': pyxisLocation},
    );
    return print('botão pressionado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3), 
      appBar: AppBar(
        backgroundColor: Color(0xFFECF0F3), 
        title: const Text(
          'Medicamentos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Medicamento Faltante:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _selectedMedicine,
                onChanged: (newValue) {
                  setState(() {
                    _selectedMedicine = newValue;
                    _productCode = '00{$_selectedMedicine}';
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
                ),
              ),
              const SizedBox(height: 20),

              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                ),
                onPressed: () {
                  // Lógica para adicionar um novo medicamento
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar medicamento'),
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Precisa Imediatamente?',
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
              const SizedBox(height: 40),

              const Text(
                'Descrição Adicional:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.black, width: 3.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: _sendRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                    textStyle: const TextStyle(fontSize: 15),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      )
        
    );
  }
}
