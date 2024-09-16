import 'package:chatapp/controllers/auth_controllers.dart';
import 'package:chatapp/controllers/chat_controllers.dart';
import 'package:chatapp/services/auth/firebase_services.dart';
import 'package:chatapp/services/chat/caht_srvices.dart';
import 'package:chatapp/views/onBoarding/on_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => AuthController(FirebaseAuthService()),
        ),
       ChangeNotifierProvider(
          create: (_) => ChatController(ChatService()),
        ),
  ],child : const ChatApp()),
  );
}

class ChatApp extends StatelessWidget  {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoardingPage(),
    );
  }
}
