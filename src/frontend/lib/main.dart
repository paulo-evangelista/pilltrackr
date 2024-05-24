import 'package:flutter/material.dart';
import 'package:frontend/views/enfermagem/choose_requests.dart'; // Importa ChooseRequests

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChooseRequests(), // Define ChooseRequests como a página inicial
    );
  }
}
