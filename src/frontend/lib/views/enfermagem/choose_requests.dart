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
        child: Center( // Centraliza todo o conteúdo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
              Text(
                'Olá, enfermeiro.\nQual o motivo da sua requisição?',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center, // Alinha o texto ao centro
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
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
              SizedBox(height: 150), // Espaço entre os botões e o botão "Entrar"
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
