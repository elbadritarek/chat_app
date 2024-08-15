import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/widgets/custom_text_from_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem(
      {super.key, required this.receiverEmail, required this.recieverID});
  final String receiverEmail;
  final String recieverID;

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(143, 176, 220, 243),
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: Column(
          children: [Expanded(child: _buildMessageList()), _buildUserInput()]),
    );
  }

  Widget _buildMessageList() {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(recieverID, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading...."));
        }
        return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList());
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid;

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(data['message']),
      ],
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: customTextFeild(
              textController: _messageController,
              hintText: "type a message",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(143, 176, 220, 243),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
