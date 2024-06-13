import 'package:flutter/material.dart';
import 'package:frontend/services/request_service.dart'; 
import '../../widgets/list_tile_nursery.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';


class MyRequests extends StatefulWidget {
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
        backgroundColor: Color(0xFFECF0F3),
        elevation: 0,
      ),

      backgroundColor: Color(0xFFECF0F3),
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ListTileNursery(title: 'Requisição #1', subtitle: 'MS1371 - Dipirona 500mgR'), 
      ),
    );
  }
}