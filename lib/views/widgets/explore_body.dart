import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class exploreBody extends StatefulWidget {
  const exploreBody({super.key, required this.currentUser});
  final String currentUser;
  @override
  State<exploreBody> createState() => _exploreBodyState();
}

class _exploreBodyState extends State<exploreBody> {
  final ChatService _chatService = ChatService();
  bool _isFriendRequset = false;
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
      stream: _chatService.getAllUsersStream(currentUser: uid),
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileExploreItem(),
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
                    await _chatService.addUserIdToFriends(uid, user.uid);
                    await _chatService.addUserIdToFriends(user.uid, uid);
                    setState(() {
                      _isFriendRequset = !_isFriendRequset;
                    });
                  },
                  icon: _isFriendRequset
                      ? Icon(Icons.person_add)
                      : Icon(Icons.person)),
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

class ProfileExploreItem extends StatelessWidget {
  const ProfileExploreItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
