import 'package:flutter/material.dart';
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
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              'Olá, \nEnfermeiro.\nQual o motivo \nda sua \nrequisição?',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left, 
            ),
            SizedBox(height: 15),
            ToggleButtons(
              isSelected: [selectedOption == 'Medicamentos', selectedOption == 'Outros'],
              onPressed: (int index) {
                setState(() {
                  selectedOption = index == 0 ? 'Medicamentos' : 'Outros';
                });
              },
              borderRadius: BorderRadius.circular(9.0),
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              fillColor: Colors.black,
              color: Colors.black,
              constraints: BoxConstraints(minHeight: 60.0, minWidth: 150.0),
              children: [
                Text('Medicamentos'),
                Text('Outros'),
              ],
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
                  } else {
                    // Adicione a navegação para a página de medicamentos, se houver
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 18),
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