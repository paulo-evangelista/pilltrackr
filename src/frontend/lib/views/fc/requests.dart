import 'package:flutter/material.dart';
import '../../widgets/list_tile_custom.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilltrackr'),
      ),
      body: const Center(
        child: ListTileCustom(title: 'Requisição #1', subtitle: 'MS1371 - Dipirona 500mgR'),
        // child: ElevatedButton(
        //   onPressed: () => _showModal(context),
        //   child: Text('Show Modal'),
        // ),
        
      ),
    );
  }
}
