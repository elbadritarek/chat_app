import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/chat/chat_view.dart';
import 'package:flutter/material.dart';

import '../../../controllers/chat_controllers.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({
    super.key,
    required this.currentUser,
  });
  final String currentUser;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  // final ChatService _chatService = ChatService();
  final ChatController _chatController = ChatController(ChatService());

  @override
  Widget build(BuildContext context) {
    return _BulidUserList(widget.currentUser);
    // return ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) {
    //     return _BulidUserList();
    //   },
    // );
  }

  Widget _BulidUserList(String uid) {
    return StreamBuilder<List<UserModel>>(
      stream: _chatController.getAllUsersStream(currentUser: uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No friends found.'));
        }

        List<UserModel> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return FutureBuilder<bool>(
              future: _chatController.areTheyMessaging(user.uid),
              builder: (context, areTheyMassagesSnapshot) {
                if (!areTheyMassagesSnapshot.hasData) {
                  return SizedBox();
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
                            : CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.displayName.isNotEmpty
                            ? user.displayName
                            : 'No Name'),
                        subtitle: Text(user.email),
                      )
                    : SizedBox();
              },
            );
          },
        );
      },
    );
  }
}
