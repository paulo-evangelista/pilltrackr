import 'package:flutter/material.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:frontend/views/nursery/feedback_request.dart';
// Views
import 'package:frontend/views/nursery/other_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilltrackr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(40, 57, 104, 1)),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/feedbackRequest':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return FeedbackRequest(
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
        '/': (context) => const NavigationMenu(),
        '/otherRequest': (context) => const OtherRequest(),
        // '/newRequests': (context) => NewRequest(),
        // '/myRequests': (context) => MyRequests(),
      },
    );
  }
}
