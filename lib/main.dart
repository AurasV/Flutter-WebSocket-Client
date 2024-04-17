import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebSocketChannel channel;
  String displayMessage = '';
  Color backgroundColor = Colors.black;
  int pushCount = 0;
  int pullCount = 0;
  String ipAddress = 'localhost';
  late TextEditingController ipController;

  @override
  void initState() {
    super.initState();
    ipController = TextEditingController(text: ipAddress);
    connectToWebSocket();
  }

  void connectToWebSocket() {
    channel = IOWebSocketChannel.connect(Uri.parse('ws://$ipAddress:8000'));
    channel.stream.listen((message) {
      processMessage(message);
    });
  }
  
  void processMessage(String message) {
    final decodedMessage = jsonDecode(message);
    final command = decodedMessage['command'];

    setState(() {
      if (command == 'push') {
        pushCount++;
        displayMessage = (pushCount % 2 == 1) ? 'Door Opened' : 'Door Closed';
      } else if (command == 'pull') {
        pullCount++;
        displayMessage = (pullCount % 2 == 1) ? 'Light On' : 'Light Off';
        backgroundColor = (pullCount % 2 == 1) ? Colors.white : Colors.black;
      }
    });
  }

  void updateIpAddress(String newIp) {
    if (newIp != ipAddress) {
      setState(() {
        ipAddress = newIp;
        ipController.text = newIp;
        channel.sink.close();
        connectToWebSocket();
      });
    }
  }

  void showIpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Set IP Address'),
          content: TextField(
            controller: ipController,
            decoration: InputDecoration(hintText: "Enter IP address"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text('Connect'),
              onPressed: () {
                updateIpAddress(ipController.text);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'WebSocket Controller',
            style: TextStyle(color: backgroundColor == Colors.white ? Colors.black : Colors.white),
          ),
          backgroundColor: backgroundColor == Colors.white ? Colors.white : Colors.black,
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => showIpDialog(context),
                );
              },
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: Center(
          child: Text(
            displayMessage,
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    ipController.dispose();
    super.dispose();
  }
}
