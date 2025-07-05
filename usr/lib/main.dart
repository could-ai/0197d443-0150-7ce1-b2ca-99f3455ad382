import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Colors.blueGrey[900],
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Map<String, List<String>> _contactMessages = {
    'Lancelot': ['Hello from Lancelot'],
    'Susu': ['Hello from Susu'],
    'Cici': ['Hello from Cici'],
    'didi': ['Hello from didi'],
    'timo': ['Hello from timo'],
    'bluesky': ['Hello from bluesky'],
    'couldai': ['Hello from couldai'],
    'aaa': ['Hello from aaa'], // 新的联系人
  };

  String _selectedContact = 'Lancelot';
  final TextEditingController _controller = TextEditingController();

  Color _backgroundColor = Colors.blueGrey[900]!;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _contactMessages[_selectedContact]?.add(_controller.text);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Dialog'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Select Background Color: ', style: TextStyle(color: Colors.white)),
                DropdownButton<Color>(
                  value: _backgroundColor,
                  items: <Color>[Colors.blueGrey[900]!, Colors.indigo, Colors.green]
                      .map((Color color) {
                    return DropdownMenuItem<Color>(
                      value: color,
                      child: Container(width: 100, height: 20, color: color),
                    );
                  }).toList(),
                  onChanged: (Color? newColor) {
                    setState(() {
                      if (newColor != null) {
                        _backgroundColor = newColor;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: _contactMessages.keys.map((contact) {
                      return ListTile(
                        title: Text(
                          contact,
                          style: TextStyle(
                            color: _selectedContact == contact ? Colors.deepPurple : Colors.white,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedContact = contact;
                          });
                        },
                        tileColor: _selectedContact == contact ? Colors.indigo[100] : null,
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: _contactMessages[_selectedContact]?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _contactMessages[_selectedContact]?[index] ?? '',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 1.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Send a message',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Colors.lightBlue[100],
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.indigo),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.indigoAccent),
                                  ),
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send, color: Colors.blue),
                              onPressed: _sendMessage,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
