import 'package:chatapp/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  Future<UserModel> getUser({required String currentUser}) async{
    final DocumentSnapshot querySnapshot = await _firestore.collection("users").doc(currentUser).get();

    return UserModel.fromDocument(querySnapshot);
  }

  Future<void> addUserIdToFriends(String currentUserId, String friendUserId) async {
  // Reference to the current user's document in the "users" collection
  DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(currentUserId);

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
}
