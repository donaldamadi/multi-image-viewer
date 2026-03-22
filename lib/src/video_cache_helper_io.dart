import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class _VideoCacheManager {
  static final CacheManager instance = CacheManager(
    Config(
      'multi_image_viewer_video_cache',
      stalePeriod: const Duration(days: 14),
      maxNrOfCacheObjects: 20,
    ),
  );
}

Future<VideoPlayerController> createNetworkVideoController(
  String url, {
  Map<String, String>? headers,
}) async {
  final cached = await _VideoCacheManager.instance.getFileFromCache(url);
  if (cached != null) {
    return VideoPlayerController.file(cached.file);
  }

  unawaited(
    _VideoCacheManager.instance.downloadFile(
      url,
      authHeaders: headers ?? const {},
    ),
  );

  return VideoPlayerController.networkUrl(
    Uri.parse(url),
    httpHeaders: headers ?? const {},
  );
}

Future<void> warmNetworkVideoCache(
  String url, {
  Map<String, String>? headers,
}) async {
  final cached = await _VideoCacheManager.instance.getFileFromCache(url);
  if (cached != null) {
    return;
  }

  await _VideoCacheManager.instance.downloadFile(
    url,
    authHeaders: headers ?? const {},
  );
}
