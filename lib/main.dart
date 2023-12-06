import 'package:chatapp/views/home_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(chatApp());
}

class chatApp extends StatelessWidget {
  const chatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoardingPage(),
    );
  }
}
