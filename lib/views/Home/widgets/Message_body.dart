import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/chat_controllers.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({
    super.key,
    required this.currentUser,
  });
  final String currentUser;

  // final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    final chatController = context.watch<ChatController>();

    return StreamBuilder<List<UserModel>>(
      stream: chatController.getAllUsersStream(currentUser: currentUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No friends found.'));
        }

        List<UserModel> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return FutureBuilder<bool>(
              future: chatController.areTheyMessaging(user.uid),
              builder: (context, areTheyMassagesSnapshot) {
                if (!areTheyMassagesSnapshot.hasData) {
                  return const SizedBox();
                }

                bool areTheyMassages = areTheyMassagesSnapshot.data!;

                return areTheyMassages
                    ? ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatView(
                                    receiverEmail: users[index].email,
                                    recieverID: users[index].uid),
                              ));
                        },
                        leading: user.photoURL.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(user.photoURL),
                              )
                            : const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.displayName.isNotEmpty
                            ? user.displayName
                            : 'No Name'),
                        subtitle: Text(user.email),
                      )
                    : const SizedBox();
              },
            );
          },
        );
      },
    );
  }
}
