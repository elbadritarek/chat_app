import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../services/agora.dart';

class AgoraController {
  final AgoraService agoraService;

  AgoraController(this.agoraService);

  Future<void> initializeAgora() async {
    await agoraService.requestPermissions();
    await agoraService.initializeEngine();
  }

  Future<void> joinChannel(String token, String channelId) async {
    await agoraService.joinChannel(token, channelId);
  }

  Future<void> leaveChannel() async {
    await agoraService.leaveChannel();
  }

  void setEventHandlers(
      {required Function(RtcConnection, int) onJoinChannelSuccess,
      required Function(RtcConnection, int, int) onUserJoined,
      required Function(RtcConnection, int, UserOfflineReasonType) onUserOffline}) {
    agoraService.setEventHandlers(
      onJoinChannelSuccess: onJoinChannelSuccess,
      onUserJoined: onUserJoined,
      onUserOffline: onUserOffline,
    );
  }

  Future<void> dispose() async {
    await agoraService.disposeEngine();
  }
}
