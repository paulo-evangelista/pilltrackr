import 'package:flutter/material.dart';
import '../../widgets/list_tile_custom.dart';

class MyRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requisições Feitas',  style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, 
          ),),
        backgroundColor: Color(0xFFECF0F3),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFECF0F3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: ListTileCustom(
                title: 'Requisição #1',
                subtitle: 'MS1371 - Dipirona 500mgR',
              ),
            ),

            SizedBox(height: 10), // Espaço entre os cards
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: ListTileCustom(
                title: 'Requisição #2',
                subtitle: 'MS1500 - Ibuprofeno 200mg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
