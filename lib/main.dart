import 'package:chatapp/views/on_board.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const chatApp());
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
