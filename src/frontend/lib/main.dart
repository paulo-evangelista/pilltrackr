import 'package:flutter/material.dart';

import 'package:frontend/views/fc/requests.dart';

import 'package:frontend/views/enfermagem/choose_requests.dart';
import 'package:frontend/views/enfermagem/new_request.dart';
import 'package:frontend/views/enfermagem/other_requests.dart';
import 'package:frontend/views/enfermagem/success_requests.dart';
import 'package:frontend/views/login/login_page.dart'; // Importando a página de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilltrackr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(40, 57, 104, 1)),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Rota inicial
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/successRequest':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return SuccessRequest(
                  requestId: args['requestId'],
                  pyxisLocation: args['pyxisLocation'],
                );
              },
            );
          default:
            return null; // Return null to use default `onUnknownRoute`
        }
      },
      routes: {
        '/':(context) => LoginPage(),
        '/otherRequest': (context) => OtherRequests(),
        '/newRequests': (context) => NewRequest(),
        '/myRequests': (context) => MyRequests(),
      },
    );
  }
}
