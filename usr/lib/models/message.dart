// Author: couldai

class Message {
  final String id;
  final String contactName;
  final String message;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.contactName,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contact_name': contactName,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      contactName: map['contact_name'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
