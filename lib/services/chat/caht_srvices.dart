import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<List<UserModel>> getAllUsersStream({required String currentUser}) {
    return _firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> users = [];
      for (var user in query.docs) {
        if (UserModel.fromDocument(user).uid != currentUser)
          users.add(UserModel.fromDocument(user));
      }
      return users;
    });
  }

  // Stream<UserModel> getUserStream({required String currentUser}) {
  //   return _firestore
  //       .collection("users")
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     return query.docs
  //         .where((doc) => UserModel.fromDocument(doc).uid != currentUser)
  //         .map((doc) => UserModel.fromDocument(doc));
  //   }).expand((userList) => userList);
  // }
  Future<UserModel> getUser({required String currentUser}) async {
    final DocumentSnapshot querySnapshot =
        await _firestore.collection("users").doc(currentUser).get();

    return UserModel.fromDocument(querySnapshot);
  }

  Future<void> addUserIdToFriends(
      String currentUserId, String friendUserId) async {
    // Reference to the current user's document in the "users" collection
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    try {
      // Fetch the current user's document
      DocumentSnapshot docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        // Get the current friends array
        List<dynamic> friends = docSnapshot.get('friends') ?? [];

        if (friends.contains(friendUserId)) {
          // If the friendUserId is already in the array, remove it
          await userDocRef.update({
            'friends': FieldValue.arrayRemove([friendUserId])
          });
          print("Friend removed successfully!");
        } else {
          // If the friendUserId is not in the array, add it
          await userDocRef.update({
            'friends': FieldValue.arrayUnion([friendUserId])
          });
          print("Friend added successfully!");
        }
      } else {
        print("User document does not exist!");
      }
    } catch (e) {
      print("Failed to toggle friend: $e");
    }
  }

  //  Stream<List<UserModel>> getAllFriendsStream({required String currentUser}) {
  //   return _firestore
  //       .collection("users").doc(currentUser).get({'friends'})

  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<UserModel> users = [];
  //     for (var user in query.docs) {
  //       if (UserModel.fromDocument(user).uid != currentUser)
  //         users.add(UserModel.fromDocument(user));
  //     }
  //     return users;
  //   });
  // }
  Stream<List<UserModel>> getAllFriendsStream({required String currentUser}) {
    return _firestore
        .collection("users")
        .doc(currentUser)
        .snapshots()
        .asyncMap((DocumentSnapshot userDoc) async {
      // Check if the document exists
      if (userDoc.exists) {
        // Get the list of friend UIDs
        List<dynamic> friendsList = userDoc.get('friends') ?? [];

        // Fetch all friend documents from the users collection
        List<UserModel> friends = [];
        for (String friendId in friendsList) {
          DocumentSnapshot friendDoc =
              await _firestore.collection("users").doc(friendId).get();
          if (friendDoc.exists) {
            friends.add(UserModel.fromDocument(friendDoc));
          }
        }
        return friends;
      } else {
        return [];
      }
    });
  }

  Future<bool> isFriend(String currentUserId, String friendUserId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    List<dynamic> friends = userDoc.get('friends') ?? [];
    return friends.contains(friendUserId);
  }

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String? currentUserEmail = _firebaseAuth.currentUser!.email;
    final Timestamp timetamp = Timestamp.now();

    Message newMessage = Message(
        message: message,
        senderId: currentUserId,
        senderEmail: currentUserEmail!,
        recieverId: receiverId,
        timestamp: timetamp);
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String UserId, otherUserId) {
    List<String> ids = [UserId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false).snapshots();
  }
}
