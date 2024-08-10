import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:flutter/material.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({super.key});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return _BulidUserList();
    // return ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) {
    //     return _BulidUserList();
    //   },
    // );
  }

  Widget _BulidUserList() {
    return StreamBuilder<List<UserModel>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found.'));
        }

        List<UserModel> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return ListTile(
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

class ProfileMessageItem extends StatelessWidget {
  const ProfileMessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileMessageItemView(),
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "userName",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "message test for chatapp hello world my name is tarek elbadri thank you for developing this app",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMessageItemView extends StatelessWidget {
  const ProfileMessageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
