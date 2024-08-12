import 'package:chatapp/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<UserModel>> getUserStream({required String currentUser}) {
    return _firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> users = [];
      for (var user in query.docs) {
        if(UserModel.fromDocument(user).uid != currentUser)
        users.add(UserModel.fromDocument(user));
      }
      return users;
    });
  }
}
