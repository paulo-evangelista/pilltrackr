import 'package:flutter/material.dart';
import 'package:frontend/views/enfermagem/choose_requests.dart';
import 'package:frontend/views/enfermagem/new_request.dart'; 
import 'package:frontend/views/enfermagem/other_requests.dart';
import 'package:frontend/views/enfermagem/success_requests.dart';
// Aplicar dotenv para host e port
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;


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
      initialRoute: '/',
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
    // Exemplo de outra rota sendo passada com parametros
    //      
          // case '/detail':
          //   final args = settings.arguments as Map<String, dynamic>;
          //   return MaterialPageRoute(
          //     builder: (context) {
          //       return DetailScreen(
          //         itemId: args['itemId'],
          //         itemName: args['itemName'],
          //       );
          //     },
          //   );
          default:
            return null; // Return null to use default `onUnknownRoute`
        }
      },
      routes: {
        '/':(context) => ChooseRequests(),
        '/otherRequest': (context) => OtherRequests(),
        '/newRequests': (context) => NewRequest(),
      },
    );
  }
}
