import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      email: doc['email'],
      displayName: doc['displayName'],
      photoURL: doc['photoURL'],
    );
  }
}
