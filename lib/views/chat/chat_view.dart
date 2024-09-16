import 'package:chatapp/views/chat/widgets/ProfileItem.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView(
      {super.key, required this.receiverEmail, required this.recieverID});
  final String receiverEmail;
  final String recieverID;
  @override
  Widget build(BuildContext context) {
    return chatViewBody(
      receiverEmail: receiverEmail,
      recieverID: recieverID,
    );
  }
}
