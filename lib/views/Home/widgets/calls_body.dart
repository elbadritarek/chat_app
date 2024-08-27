import 'package:chatapp/controllers/agora_controller.dart';
import 'package:chatapp/controllers/chat_controllers.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/agora.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/chat/chat_view.dart';
import 'package:chatapp/views/vocie_call/Voice_call_view.dart';
import 'package:flutter/material.dart';

import '../../../utils/settings.dart';

class callsBody extends StatefulWidget {
  const callsBody({super.key, required this.currentUser});
  final String currentUser;

  @override
  State<callsBody> createState() => _callsBodyState();
}

class _callsBodyState extends State<callsBody> {
  final ChatController _chatController = ChatController(ChatService());
  final AgoraController _agoraController = AgoraController(AgoraService());

  @override
  Widget build(BuildContext context) {
    return _BulidUserList(widget.currentUser);
  }

  Widget _BulidUserList(String uid) {
    return StreamBuilder<List<UserModel>>(
      stream: _chatController.getAllFriendsStream(uid),
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
            return ListTile(
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
              title: Text(
                  user.displayName.isNotEmpty ? user.displayName : 'No Name'),
              subtitle: Text(user.email),
              trailing: IconButton(
                  onPressed: () async {
                    await _agoraController.initializeAgora();
                    await _agoraController.joinChannel(token, channel);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VoiceCallView(),
                        ));
                  },
                  icon: Icon(Icons.phone)),
            );
          },
        );
      },
    );
  }
}
