
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/UserModel.dart';
import '../../models/message.dart';

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
        if (UserModel.fromDocument(user).uid != currentUser) {
          users.add(UserModel.fromDocument(user));
        }
      }
      return users;
    });
  }

  Future<UserModel> getUser({required String currentUser}) async {
    final DocumentSnapshot querySnapshot =
        await _firestore.collection("users").doc(currentUser).get();
    return UserModel.fromDocument(querySnapshot);
  }

  Future<void> toggleFriend(String currentUserId, String friendUserId) async {
    DocumentReference userDocRef =
        _firestore.collection('users').doc(currentUserId);

    DocumentSnapshot docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      List<dynamic> friends = docSnapshot.get('friends') ?? [];
      if (friends.contains(friendUserId)) {
        await userDocRef.update({
          'friends': FieldValue.arrayRemove([friendUserId])
        });
      } else {
        await userDocRef.update({
          'friends': FieldValue.arrayUnion([friendUserId])
        });
      }
    }
  }

  Stream<List<UserModel>> getAllFriendsStream({required String currentUser}) {
    return _firestore
        .collection("users")
        .doc(currentUser)
        .snapshots()
        .asyncMap((DocumentSnapshot userDoc) async {
      if (userDoc.exists) {
        List<dynamic> friendsList = userDoc.get('friends') ?? [];
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

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String? currentUserEmail = _firebaseAuth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      message: message,
      senderId: currentUserId,
      senderEmail: currentUserEmail!,
      recieverId: receiverId,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessageStream(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<bool> areTheyMessaging(String friendUserId) async {
    final String currentUser = _firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUser, friendUserId];
    ids.sort();
    String chatRoomID = ids.join("_");

    QuerySnapshot querySnapshot = await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
