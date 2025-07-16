// Author: bluesky

import 'package:flutter/material.dart';

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
    'bluesky': ['Hello from Bluesky'],
    'timo': ['Hello from Timo'],
    'couldai': ['Hello from CouldAI'],
  };

  String _selectedContact = 'Lancelot';
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _newContactController = TextEditingController();
  
  Color _backgroundColor = Colors.blueGrey[900]!;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _contactMessages[_selectedContact]?.add(_controller.text);
      });
      _controller.clear();
    }
  }

  void _deleteContact(String contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete $contact?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  _contactMessages.remove(contact);
                  if (_selectedContact == contact && _contactMessages.isNotEmpty) {
                    _selectedContact = _contactMessages.keys.first;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addContact() {
    if (_newContactController.text.isNotEmpty) {
      setState(() {
        if (!_contactMessages.containsKey(_newContactController.text)) {
          _contactMessages[_newContactController.text] = [];
          _selectedContact = _newContactController.text;
        }
      });
      _newContactController.clear();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _newContactController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a new contact',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: _addContact,
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
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteContact(contact),
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
                        color: Colors.black54,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Send a message',
                                  hintStyle: TextStyle(color: Colors.white54),
                                  filled: true,
                                  fillColor: Colors.grey[800],
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent),
                                  ),
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(Icons.send, size: 30.0, color: Colors.white),
                                onPressed: _sendMessage,
                                splashRadius: 20.0,
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
          ),
        ],
      ),
    );
  }
}
