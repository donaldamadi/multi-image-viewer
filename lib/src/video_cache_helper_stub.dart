import 'package:video_player/video_player.dart';

Future<VideoPlayerController> createNetworkVideoController(
  String url, {
  Map<String, String>? headers,
}) async {
  return VideoPlayerController.networkUrl(
    Uri.parse(url),
    httpHeaders: headers ?? const {},
  );
}

Future<void> warmNetworkVideoCache(
  String url, {
  Map<String, String>? headers,
}) async {}
