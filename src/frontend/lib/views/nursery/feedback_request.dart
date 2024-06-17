import 'package:flutter/material.dart';
import 'package:frontend/views/nursery/my_requests.dart';

class FeedbackRequest extends StatelessWidget {
  final String requestId;
  final String pyxisLocation;

  const FeedbackRequest({super.key, required this.requestId, required this.pyxisLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF0F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF0F3),
        title: const Text(
          'Sucesso!',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            RichText(
              text: TextSpan(
                text: 'A ',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Requisição $requestId ', style: const TextStyle(color: Colors.purple,)),
                  const TextSpan(text: 'foi feita com sucesso!', style: TextStyle(color: Colors.black,)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            RichText(
              text: TextSpan(
                text: 'Pyxis mais próximo com os medicamentos:  ',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: '\n$pyxisLocation ', style: const TextStyle(color: Colors.purple,)),
                ],
              ),
            ),
            const SizedBox(height: 70),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyRequests()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  textStyle: const TextStyle(fontSize: 15),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Ir para requisições feitas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
