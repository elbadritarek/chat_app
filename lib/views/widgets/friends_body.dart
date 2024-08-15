import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/widgets/ProfileItem.dart';
import 'package:flutter/material.dart';

class friendsBody extends StatefulWidget {
  const friendsBody({
    super.key,
    required this.currentUser,
  });
  final String currentUser;
  @override
  State<friendsBody> createState() => _friendsBodyState();
}

class _friendsBodyState extends State<friendsBody> {
  final ChatService _chatService = ChatService();
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
                      builder: (context) => ProfileItem(receiverEmail: users[index].email,recieverID: users[index].uid),
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
            );
          },
        );
      },
    );
  }
}
