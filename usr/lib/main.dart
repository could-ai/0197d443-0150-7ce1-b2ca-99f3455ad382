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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black,
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
    'Contact 1': ['Hello from Contact 1'],
    'Contact 2': ['Hello from Contact 2'],
    'Contact 3': ['Hello from Contact 3'],
  };

  String _selectedContact = 'Contact 1';
  final TextEditingController _controller = TextEditingController();

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
        backgroundColor: Colors.deepPurple,
      ),
      body: Row(
        children: <Widget>[
          // Contacts List
          Expanded(
            flex: 1,
            child: ListView(
              children: _contactMessages.keys.map((contact) {
                return ListTile(
                  title: Text(
                    contact,
                    style: TextStyle(
                      color: _selectedContact == contact ? Colors.blue : Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedContact = contact;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Chat Messages
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
                          decoration: const InputDecoration(
                            hintText: 'Send a message',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.black12,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
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
    );
  }
}
