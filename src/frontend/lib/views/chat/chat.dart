import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
    final token = 'admin';
    final url = 'wss://pilltrackr.cathena.io/ws/?token=$token';

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      
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
        author: types.User(id: message['from']), // Assumindo que 'from' é o ID do autor
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message['content'],
      );

      _addMessage(newMessage, incoming: true);
    }
  }

  void _addMessage(types.Message message, {bool incoming = false}) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
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
          author: isSentByUser ? _user : _admin, // Define o autor com base em SentByUser
          createdAt: DateTime.parse(json['CreatedAt']).millisecondsSinceEpoch,
          id: json['ID'].toString(), // Convertendo ID para string
          text: json['Content'],
        );
      }).toList();

      setState(() {
        _messages = messages;
      });
    } else {
      print('Failed to load messages');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );
}
