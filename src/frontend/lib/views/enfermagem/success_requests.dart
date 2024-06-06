import 'package:flutter/material.dart';
import 'requests.dart'; // Importa a página MyRequests

class SuccessRequest extends StatelessWidget {
  final String requestId;
  final String pyxisLocation;

  SuccessRequest({required this.requestId, required this.pyxisLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F3),
      appBar: AppBar(
        backgroundColor: Color(0xFFECF0F3),
        title: Text(
          'Sucesso',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A requisição \n$requestId foi feita com \nsucesso!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              'Pyxis mais \npróximo com os \nmedicamentos:',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,),
              textAlign: TextAlign.left,
            ),
            Text(
              pyxisLocation,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 70),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyRequests()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  textStyle: TextStyle(fontSize: 15),
                  foregroundColor: Colors.white,
                ),
                child: Text('Ir para requisições feitas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
