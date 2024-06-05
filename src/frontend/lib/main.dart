import 'package:flutter/material.dart';
import 'package:frontend/views/chat/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(40, 57, 104, 1)),
        useMaterial3: true,
      ),
      home: const ChatPage(),
    );
  }
}
