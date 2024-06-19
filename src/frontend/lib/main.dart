import 'package:flutter/material.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:frontend/views/nursery/feedback_request.dart';
// Views
import 'package:frontend/views/nursery/home.dart';
import 'package:frontend/views/nursery/other_request.dart';
import 'package:frontend/views/chat/chat.dart';

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
      initialRoute: '/chat',
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
          // case '/chat':
          //   final args = settings.arguments as Map<String, dynamic>;
          //   return MaterialPageRoute(
          //     builder: (context) {
          //       return ChatPage(
          //         requestId: args['requestId'],
          //         userToken: args['userToken'],
          //       );
          //     },
          //   );
          default:
            return null; // Return null to use default `onUnknownRoute`
        }
      },
      routes: {
        '/': (context) => NavigationMenu(),
        '/otherRequest': (context) => OtherRequest(),
        // '/newRequests': (context) => NewRequest(),
        // '/myRequests': (context) => MyRequests(),
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}
