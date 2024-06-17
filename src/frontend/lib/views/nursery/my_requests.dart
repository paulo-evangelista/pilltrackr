import 'package:flutter/material.dart';
import '../../widgets/list_tile_nursery.dart';
// import 'package:http/http.dart' as http;


class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requisições Feitas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFECF0F3),
        elevation: 0,
      ),

      backgroundColor: const Color(0xFFECF0F3),
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ListTileNursery(title: 'Requisição #1', subtitle: 'MS1371 - Dipirona 500mgR'), 
      ),
    );
  }
}