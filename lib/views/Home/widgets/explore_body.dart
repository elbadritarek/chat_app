import 'package:chatapp/controllers/chat_controllers.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class exploreBody extends StatelessWidget {
  const exploreBody({super.key, required this.currentUser});
  final String currentUser;
  @override
 
  @override
  Widget build(BuildContext context) {
      final chatController = context.watch<ChatController>();

    return StreamBuilder<List<UserModel>>(
      stream: chatController.getAllUsersStream(currentUser: currentUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        List<UserModel> users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return FutureBuilder<bool>(
              future: chatController.isFriend(currentUser, user.uid),
              builder: (context, isFriendSnapshot) {
                if (!isFriendSnapshot.hasData) {
                  return const CircularProgressIndicator();
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
                      : const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.displayName.isNotEmpty
                      ? user.displayName
                      : 'No Name'),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                      onPressed: () async {
                        await chatController.toggleFriend(currentUser, user.uid);
                        await chatController.toggleFriend(user.uid, currentUser);

                      // chatController.notifyListeners();
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


