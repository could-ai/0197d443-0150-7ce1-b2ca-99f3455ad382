// Author: couldai

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
  
  Color _backgroundColor = Colors.white;

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
        title: const Text('Chat with CouldAI'),
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _newContactController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Add a new contact',
                      hintStyle: TextStyle(color: Colors.black38),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.indigoAccent),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView(
                      children: _contactMessages.keys.map((contact) {
                        return ListTile(
                          title: Text(
                            contact,
                            style: TextStyle(
                              color: _selectedContact == contact ? Colors.indigoAccent : Colors.black87,
                              fontWeight: _selectedContact == contact ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.red),
                            onPressed: () => _deleteContact(contact),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedContact = contact;
                            });
                          },
                          tileColor: _selectedContact == contact ? Colors.indigo[50] : Colors.white,
                        );
                      }).toList(),
                    ),
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
                                style: TextStyle(color: Colors.black87),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 1.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(Icons.send, size: 30.0, color: Colors.indigoAccent),
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
