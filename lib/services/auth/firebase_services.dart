
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      if (user != null) {
        await user.updateDisplayName(username);
        await user.reload();
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'displayName': username,
          'photoURL': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
          'friends': [],
        });
        return _firebaseAuth.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
    return null;
  }
}
