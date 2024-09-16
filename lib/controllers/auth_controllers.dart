
import 'package:chatapp/services/auth/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{
  final FirebaseAuthService _authService;

  AuthController(this._authService);

  Future<void> signIn(
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey,
      required BuildContext context,
      required Function(User) onSuccess}) async {
    if (formKey.currentState!.validate()) {
      try {
        User? user =
            await _authService.signInWithEmailAndPassword(email, password);
        if (user != null) {
             notifyListeners();
          onSuccess(user);
          _showSnackBar(context: context, data: "Sign In successful");
        } else {
          _showSnackBar(context: context, data: "Wrong password or email");
        }
      } on FirebaseAuthException catch (e) {
        _handleAuthErrors(context, e);
      }
    }
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password,
      required GlobalKey<FormState> formKey,
      required BuildContext context,
      required Function(User) onSuccess}) async {
    if (formKey.currentState!.validate()) {
      try {
        User? user = await _authService.createUserWithEmailAndPassword(
          username,
          email,
          password,
        );
        if (user != null) {
             notifyListeners();
          onSuccess(user);
          _showSnackBar(context: context, data: "Sign Up successful");
        }
      } on FirebaseAuthException catch (e) {
        _handleAuthErrors(context, e);
      }
    }
  }

  void _handleAuthErrors(BuildContext context, FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      _showSnackBar(context: context, data: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      _showSnackBar(
          context: context, data: 'Wrong password provided for that user.');
    } else if (e.code == 'weak-password') {
      _showSnackBar(
          context: context, data: 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      _showSnackBar(
          context: context, data: 'The account already exists for that email.');
    }
  }

  void _showSnackBar({required BuildContext context, required String data}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
