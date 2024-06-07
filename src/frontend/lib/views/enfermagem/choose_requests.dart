import 'package:flutter/material.dart';
import 'package:frontend/views/enfermagem/new_request.dart'; 
import 'package:frontend/views/enfermagem/other_requests.dart';

class ChooseRequests extends StatefulWidget {
  @override
  _ChooseRequestsState createState() => _ChooseRequestsState();
}

class _ChooseRequestsState extends State<ChooseRequests> {
  String selectedOption = 'Medicamentos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, \nEnfermeiro.\nQual o motivo \nda sua \nrequisição?',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 22.5), // Adiciona margem à esquerda
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5), // Adiciona a moldura
                  borderRadius: BorderRadius.circular(25.0), // Bordas mais circulares
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0), // Bordas mais circulares
                  child: ToggleButtons(
                    isSelected: [selectedOption == 'Medicamentos', selectedOption == 'Outros'],
                    onPressed: (int index) {
                      setState(() {
                        selectedOption = index == 0 ? 'Medicamentos' : 'Outros';
                      });
                    },
                    borderColor: Colors.transparent,
                    selectedBorderColor: Colors.transparent,
                    fillColor: Colors.black,
                    color: Colors.black,
                    selectedColor: Colors.white,
                    constraints: BoxConstraints(minHeight: 70.0, minWidth: 150.0),
                    children: [
                      Text('Medicamentos'),
                      Text('Outros'),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(), // Adicione um espaço flexível
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption == 'Outros') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtherRequests()),
                    );
                  } else if (selectedOption == 'Medicamentos') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRequest()), // Navega para NewRequest
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                  textStyle: TextStyle(fontSize: 15),
                  foregroundColor: Colors.white,
                ),
                child: Text('Entrar'),
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
