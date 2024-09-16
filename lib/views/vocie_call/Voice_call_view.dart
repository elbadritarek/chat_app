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
      backgroundColor: const Color.fromARGB(255, 2, 23, 40),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(82, 158, 158, 158),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: const Icon(Icons.volume_up, size: 32, color: Colors.white),
                  ),
                  const Text(
                    "Speaker",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              GestureDetector(
                onTap: () async {
                  await _agoraController.leaveChannel();
                  // Check if the widget is still mounted before navigating
                  if (!context.mounted) return;

                  Navigator.pop(context);
                },
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: const Icon(Icons.call_end, size: 48, color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(82, 158, 158, 158),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: const Icon(Icons.mic, size: 32, color: Colors.white),
                  ),
                  const Text(
                    "mute",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
