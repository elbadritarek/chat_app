import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Iterable<Map<String, dynamic>>>> getUserStream() {
   return _firestore
        .collection("users")
        .snapshots()
        .map((snap) => snap.docs.map((doc) {
              final user = doc.data();
              return user;
            })).toList();
  }
}
