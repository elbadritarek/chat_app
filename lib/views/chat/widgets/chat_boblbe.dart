import 'package:flutter/material.dart';

class chatBobble extends StatelessWidget {
  const chatBobble({super.key, required this.message, required this.isCurrent});
  final String message;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCurrent ? Color.fromARGB(143, 176, 220, 243) : Colors.green,
      ),
      child: Text(message),
    );
  }
}
