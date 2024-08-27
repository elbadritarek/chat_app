import 'package:chatapp/controllers/chat_controllers.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/chat/chat_view.dart';
import 'package:flutter/material.dart';

class exploreBody extends StatefulWidget {
  const exploreBody({super.key, required this.currentUser});
  final String currentUser;
  @override
  State<exploreBody> createState() => _exploreBodyState();
}

class _exploreBodyState extends State<exploreBody> {
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
          // return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found.'));
        }

        List<UserModel> users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return FutureBuilder<bool>(
              future: _chatController.isFriend(uid, user.uid),
              builder: (context, isFriendSnapshot) {
                if (!isFriendSnapshot.hasData) {
                  return CircularProgressIndicator();
                }
                bool isFriend = isFriendSnapshot.data!;

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
                  title: Text(user.displayName.isNotEmpty
                      ? user.displayName
                      : 'No Name'),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                      onPressed: () async {
                        await _chatController.toggleFriend(uid, user.uid);
                        await _chatController.toggleFriend(user.uid, uid);

                        setState(() {});
                      },
                      icon: Icon(isFriend ? Icons.person : Icons.person_add)),
                );
              },
            );
          },
        );
      },
    );
  }
}



// class ProfileMessageItem extends StatelessWidget {
//   const ProfileMessageItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProfileMessageItemView(),
//               ));
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           //margin: EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(color: Colors.blue[50]),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "userName",
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     Text(
//                       "message test for chatapp hello world my name is tarek elbadri thank you for developing this app",
//                       overflow: TextOverflow.clip,
//                       maxLines: 1,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


