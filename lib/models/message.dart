import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String recieverId;
  final String senderId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.recieverId,
      required this.senderId,
      required this.senderEmail,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'recieverId': recieverId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
        recieverId: doc['recieverId'],
        senderId: doc['senderId'],
        senderEmail: doc['senderEmail'],
        message: doc['message'],
        timestamp: doc['timestamp']);
  }
}
