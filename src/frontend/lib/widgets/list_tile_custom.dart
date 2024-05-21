import 'package:flutter/material.dart';

class ListTileCustom extends StatefulWidget {
  final String title;
  final String subtitle;

  const ListTileCustom({super.key, required this.title, required this.subtitle});

  @override
  _ListTileCustomState createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  late String _title;
  late String _subtitle;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _subtitle = widget.subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Sample')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: Text(_title),
              subtitle: Text(_subtitle),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
