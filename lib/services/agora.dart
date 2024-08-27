
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/settings.dart';

class AgoraService {
  late RtcEngine _engine;

  Future<void> initializeEngine() async {
    _engine = await createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  Future<void> requestPermissions() async {
    await [Permission.microphone].request();
  }

  Future<void> joinChannel(String token, String channelId) async {
    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      options: const ChannelMediaOptions(
        autoSubscribeAudio: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> disposeEngine() async {
    await _engine.release();
  }

  void setEventHandlers(
      {required Function(RtcConnection, int) onJoinChannelSuccess,
      required Function(RtcConnection, int, int) onUserJoined,
      required Function(RtcConnection, int, UserOfflineReasonType) onUserOffline}) {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: onJoinChannelSuccess,
        onUserJoined: onUserJoined,
        onUserOffline: onUserOffline,
      ),
    );
  }
}
