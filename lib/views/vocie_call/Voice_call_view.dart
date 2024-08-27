import 'package:chatapp/controllers/agora_controller.dart';
import 'package:flutter/material.dart';

import '../../services/agora.dart';

class VoiceCallView extends StatefulWidget {
  @override
  _VoiceCallViewState createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends State<VoiceCallView> {
  final AgoraController _agoraController = AgoraController(AgoraService());

  @override
  void initState() {
    super.initState();
    _agoraController.initializeAgora();
  }

  @override
  void dispose() {
    _agoraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Call"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _agoraController.leaveChannel();
                Navigator.pop(context);
              },
              child: Icon(Icons.phone_disabled_rounded, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
