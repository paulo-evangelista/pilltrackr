import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: ChatPage(),
        ),
      );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _admin = const types.User(
    id: 'admin-id',
  );
  final int request = 1;
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    final token = "paulo";
    final url = 'wss://pilltrackr.cathena.io/ws/?token=$token';

    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));

      _channel.stream.listen((message) {
        final decodedMessage = json.decode(message);
        _handleIncomingMessage(decodedMessage);
        print('Received: $decodedMessage');
      }, onError: (error) {
        print('WebSocket error: $error');
        // Tentar reconectar após um tempo
        Future.delayed(Duration(seconds: 5), () => _connectWebSocket());
      }, onDone: () {
        print('WebSocket closed');
        // Tentar reconectar após um tempo
        Future.delayed(Duration(seconds: 5), () => _connectWebSocket());
      });
    } catch (e) {
      print('WebSocketChannelException: $e');
    }
  }

  void _handleIncomingMessage(Map<String, dynamic> message) {
    if (message['request'] == request) {
      final newMessage = types.TextMessage(
        author: types.User(id: message['from']),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message['content'],
      );

      _addMessage(newMessage, incoming: true);
    }
  }

  void _addMessage(types.Message message, {bool incoming = false}) {
    setState(() {
      _messages.add(message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    final wsMessage = {
      "request": request,
      "content": message.text,
    };
    _channel.sink.add(json.encode(wsMessage));
  }

  void _loadMessages() async {
    final response = await http.get(
      Uri.parse('https://pilltrackr.cathena.io/api/request/$request/messages'),
      headers: {
        'Authorization': 'Bearer admin',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonMessages = json.decode(response.body);
      final messages = jsonMessages.map((json) {
        final isSentByUser = json['SentByUser'] ?? false;

        return types.TextMessage(
          author: isSentByUser ? _user : _admin,
          createdAt: DateTime.parse(json['CreatedAt']).millisecondsSinceEpoch,
          id: json['ID'].toString(),
          text: json['Content'],
        );
      }).toList();

      setState(() {
        _messages = messages.reversed.toList(); // Inverter a lista de mensagens
      });
    } else {
      print('Failed to load messages');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loadMessages,
          child: const Icon(Icons.refresh),
        ),
      );
}
