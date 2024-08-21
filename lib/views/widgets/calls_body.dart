import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/agora.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/Voice_call_view.dart';
import 'package:chatapp/views/widgets/ProfileItem.dart';
import 'package:flutter/material.dart';

class callsBody extends StatefulWidget {
  const callsBody({super.key, required this.currentUser});
  final String currentUser;

  @override
  State<callsBody> createState() => _callsBodyState();
}

class _callsBodyState extends State<callsBody> {
  final ChatService _chatService = ChatService();
  final AgoraService _agoraService = AgoraService();

  @override
  Widget build(BuildContext context) {
    return _BulidUserList(widget.currentUser);
  }

  Widget _BulidUserList(String uid) {
    return StreamBuilder<List<UserModel>>(
      stream: _chatService.getAllFriendsStream(currentUser: uid),
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
                      builder: (context) => ProfileItem(
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
                    await _agoraService.initializeAgora();

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
