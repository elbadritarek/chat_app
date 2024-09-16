
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/UserModel.dart';

// class ChatController {
//   final chatService;

//   ChatController(this.chatService);

//   Stream<List<UserModel>> getAllUsersStream({required String currentUser}) {
//     return chatService.getAllUsersStream(currentUser: currentUser);
//   }

//   Future<UserModel> getUser(String currentUser) async {
//     return chatService.getUser(currentUser: currentUser);
//   }

//   Future<void> toggleFriend(String currentUserId, String friendUserId) async {
//     return chatService.toggleFriend(currentUserId, friendUserId);
//   }

//   Stream<List<UserModel>> getAllFriendsStream(String currentUser) {
//     return chatService.getAllFriendsStream(currentUser: currentUser);
//   }

//   Future<bool> isFriend(String currentUserId, String friendUserId) async {
//     return chatService.isFriend(currentUserId, friendUserId);
//   }

//   Future<void> sendMessage(String receiverId, String message) async {
//     return chatService.sendMessage(receiverId, message);
//   }

//   Stream<QuerySnapshot> getMessageStream(String userId, String otherUserId) {
//     return chatService.getMessageStream(userId, otherUserId);
//   }

//   Future<bool> areTheyMessaging(String friendUserId) async {
//     return chatService.areTheyMessaging(friendUserId);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import '../services/chat/caht_srvices.dart';

class ChatController extends ChangeNotifier {
  final ChatService chatService;

  ChatController(this.chatService);

  Stream<List<UserModel>> getAllUsersStream({required String currentUser}) {
    return chatService.getAllUsersStream(currentUser: currentUser);
  }

  Future<UserModel> getUser(String currentUser) async {
    return chatService.getUser(currentUser: currentUser);
  }

  Future<void> toggleFriend(String currentUserId, String friendUserId) async {
    await chatService.toggleFriend(currentUserId, friendUserId);
    notifyListeners();
  }

  Stream<List<UserModel>> getAllFriendsStream(String currentUser) {
    return chatService.getAllFriendsStream(currentUser: currentUser);
  }

  Future<bool> isFriend(String currentUserId, String friendUserId) async {
    return chatService.isFriend(currentUserId, friendUserId);
  }

  Future<void> sendMessage(String receiverId, String message) async {
    await chatService.sendMessage(receiverId, message);
    notifyListeners();
  }

  Stream<QuerySnapshot> getMessageStream(String userId, String otherUserId) {
    return chatService.getMessageStream(userId, otherUserId);
  }

  Future<bool> areTheyMessaging(String friendUserId) async {
    return chatService.areTheyMessaging(friendUserId);
  }
}
