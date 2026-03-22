// ignore_for_file: use_build_context_synchronously
import 'src/media_save_helper_stub.dart'
    if (dart.library.io) 'src/media_save_helper_io.dart' as media_save_helper;
import 'src/video_cache_helper_stub.dart'
    if (dart.library.io) 'src/video_cache_helper_io.dart' as video_cache_helper;
import 'multi_image_layout.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    this.galleryItems,
    this.mediaItems,
    this.captions,
    this.scrollDirection = Axis.horizontal,
    this.headers,
    this.enableSave = true,
    this.autoPlay = true,
  })  : assert(galleryItems != null || mediaItems != null),
        pageController = PageController(initialPage: initialIndex ?? 0);

  final BoxDecoration? backgroundDecoration;
  final List<String>? galleryItems;
  final List<ImageModel>? mediaItems;
  final List<String>? captions;
  final Map<String, String>? headers;
  final int? initialIndex;
  final LoadingBuilder? loadingBuilder;
  final dynamic maxScale;
  final dynamic minScale;
  final PageController pageController;
  final Axis scrollDirection;
  final bool enableSave;
  final bool autoPlay;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late final List<ImageModel> _items;
  int currentIndex = 0;
  bool showCaptions = false;

  @override
  void initState() {
    super.initState();
    _items = widget.mediaItems ??
        widget.galleryItems!
            .map((item) => ImageModel(imageUrl: item))
            .toList(growable: false);
    currentIndex = widget.initialIndex ?? 0;
    _checkCaptionLength();
    _warmVisibleVideoCache();
  }

  void _warmVisibleVideoCache() {
    for (final item in _items
        .where((item) => item.isVideo && _isNetworkSource(item.sourceUrl))) {
      video_cache_helper.warmNetworkVideoCache(
        item.sourceUrl,
        headers: widget.headers,
      );
    }
  }

  void _checkCaptionLength() {
    final captions = _captions;
    if (captions != null && captions.length == _items.length) {
      showCaptions = true;
    }
  }

  List<String>? get _captions {
    if (widget.captions != null) {
      return widget.captions;
    }

    if (_items
        .any((item) => item.caption != null && item.caption!.isNotEmpty)) {
      return _items.map((item) => item.caption ?? '').toList(growable: false);
    }

    return null;
  }

  ImageModel get _currentItem => _items[currentIndex];

  bool _isNetworkSource(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  String _fileNameFor(ImageModel item) {
    final parsed = Uri.tryParse(item.sourceUrl);
    final lastSegment = parsed?.pathSegments.isNotEmpty == true
        ? parsed!.pathSegments.last
        : '';
    if (lastSegment.isNotEmpty) {
      return lastSegment;
    }
    return item.isVideo
        ? 'video-${DateTime.now().millisecondsSinceEpoch}.mp4'
        : 'image-${DateTime.now().millisecondsSinceEpoch}.png';
  }

  Future<bool> _saveImage(ImageModel item) async {
    if (_isNetworkSource(item.sourceUrl)) {
      final response = await Dio().get<List<int>>(
        item.sourceUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: widget.headers,
        ),
      );
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.data ?? const []),
        quality: 80,
        name: _fileNameFor(item),
      );
      return result['isSuccess'] == true;
    }

    final byteData = await rootBundle.load(item.sourceUrl);
    final result = await ImageGallerySaverPlus.saveImage(
      byteData.buffer.asUint8List(),
      quality: 80,
      name: _fileNameFor(item),
    );
    return result['isSuccess'] == true;
  }

  Future<bool> _saveVideo(ImageModel item) async {
    final Uint8List bytes;
    if (_isNetworkSource(item.sourceUrl)) {
      final response = await Dio().get<List<int>>(
        item.sourceUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: widget.headers,
        ),
      );
      bytes = Uint8List.fromList(response.data ?? const []);
    } else {
      final byteData = await rootBundle.load(item.sourceUrl);
      bytes = byteData.buffer.asUint8List();
    }

    final filePath = (await media_save_helper.writeBytesToTemporaryFile(
      bytes,
      _fileNameFor(item),
    ))
        .path;

    final result = await ImageGallerySaverPlus.saveFile(
      filePath,
      name: _fileNameFor(item),
    );
    return result['isSuccess'] == true;
  }

  Future<void> _saveCurrentItem() async {
    bool status = false;
    try {
      status = _currentItem.isVideo
          ? await _saveVideo(_currentItem)
          : await _saveImage(_currentItem);
    } catch (_) {
      status = false;
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status ? 'Media saved to gallery' : 'Error saving media',
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final captions = _captions;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 41, 7),
      body: Container(
        decoration: widget.backgroundDecoration ??
            const BoxDecoration(
              color: Color.fromARGB(255, 13, 39, 6),
            ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: widget.pageController,
              itemCount: _items.length,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
              itemBuilder: (context, index) {
                final item = _items[index];
                if (item.isVideo) {
                  return _FullscreenVideoPage(
                    item: item,
                    headers: widget.headers,
                    autoPlay: widget.autoPlay,
                    isActive: index == currentIndex,
                    backgroundDecoration: widget.backgroundDecoration,
                  );
                }

                return _FullscreenImagePage(
                  item: item,
                  headers: widget.headers,
                  loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration: widget.backgroundDecoration,
                );
              },
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: _currentItem.isVideo ? 120 : 20,
              child: Align(
                alignment:
                    showCaptions ? Alignment.center : Alignment.centerRight,
                child: showCaptions
                    ? ReadMoreText(
                        captions![currentIndex],
                        trimLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        colorClickableText: Colors.white,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Item ${currentIndex + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
              ),
            ),
            Positioned(
              top: 80,
              left: 15,
              child: IconButton(
                color: Colors.white,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            if (widget.enableSave)
              Positioned(
                top: 80,
                right: 15,
                child: IconButton(
                  color: Colors.white,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.download),
                  onPressed: _saveCurrentItem,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _FullscreenImagePage extends StatelessWidget {
  const _FullscreenImagePage({
    required this.item,
    required this.headers,
    required this.loadingBuilder,
    required this.backgroundDecoration,
  });

  final ImageModel item;
  final Map<String, String>? headers;
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;

  bool get _isNetworkSource =>
      item.sourceUrl.startsWith('http://') ||
      item.sourceUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (_isNetworkSource) {
      return PhotoView(
        imageProvider: CachedNetworkImageProvider(
          item.sourceUrl,
          headers: headers,
        ),
        loadingBuilder: loadingBuilder,
        backgroundDecoration: backgroundDecoration ??
            const BoxDecoration(
              color: Colors.black,
            ),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 4.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.sourceUrl),
      );
    }

    return PhotoView(
      imageProvider: AssetImage(item.sourceUrl),
      backgroundDecoration: backgroundDecoration ??
          const BoxDecoration(
            color: Colors.black,
          ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.sourceUrl),
    );
  }
}

class _FullscreenVideoPage extends StatefulWidget {
  const _FullscreenVideoPage({
    required this.item,
    required this.headers,
    required this.autoPlay,
    required this.isActive,
    required this.backgroundDecoration,
  });

  final ImageModel item;
  final Map<String, String>? headers;
  final bool autoPlay;
  final bool isActive;
  final BoxDecoration? backgroundDecoration;

  @override
  State<_FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<_FullscreenVideoPage> {
  VideoPlayerController? _controller;
  bool _isInitializing = true;
  bool _isMuted = false;
  bool _hasError = false;
  bool _isScrubbing = false;
  Duration _scrubPosition = Duration.zero;

  bool get _isNetworkSource =>
      widget.item.sourceUrl.startsWith('http://') ||
      widget.item.sourceUrl.startsWith('https://');

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(covariant _FullscreenVideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive ||
        widget.autoPlay != oldWidget.autoPlay) {
      _syncPlaybackState();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeController() async {
    try {
      final VideoPlayerController controller;
      if (_isNetworkSource) {
        controller = await video_cache_helper.createNetworkVideoController(
          widget.item.sourceUrl,
          headers: widget.headers,
        );
      } else {
        controller = VideoPlayerController.asset(widget.item.sourceUrl);
      }

      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(1);

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
        _isInitializing = false;
        _hasError = false;
      });

      await _syncPlaybackState();
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isInitializing = false;
        _hasError = true;
      });
    }
  }

  Future<void> _syncPlaybackState() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (widget.isActive && widget.autoPlay) {
      await _controller!.play();
    } else {
      await _controller!.pause();
    }
  }

  Future<void> _togglePlayback() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (_controller!.value.isPlaying) {
      await _controller!.pause();
    } else {
      await _controller!.play();
    }

    if (mounted) {
      setState(() {});
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _toggleMute() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    _isMuted = !_isMuted;
    await _controller!.setVolume(_isMuted ? 0 : 1);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white54,
          size: 32,
        ),
      );
    }

    if (_isInitializing ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PhotoView.customChild(
          backgroundDecoration: widget.backgroundDecoration ??
              const BoxDecoration(
                color: Colors.black,
              ),
          childSize: _controller!.value.size,
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 4.0,
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller!,
          builder: (context, value, child) {
            final duration = value.duration;
            final position = _isScrubbing
                ? _scrubPosition
                : value.position > duration
                    ? duration
                    : value.position;
            final maxSeconds = duration.inMilliseconds > 0
                ? duration.inMilliseconds / 1000
                : 1.0;
            final currentSeconds =
                position.inMilliseconds.clamp(0, duration.inMilliseconds) /
                    1000;

            return Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: IconButton(
                      iconSize: 38,
                      color: Colors.white,
                      onPressed: _togglePlayback,
                      icon: Icon(
                        value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 86,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: _toggleMute,
                      icon: Icon(
                        _isMuted ? Icons.volume_off : Icons.volume_up,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 18,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12,
                              ),
                            ),
                            child: Slider(
                              value: currentSeconds.toDouble(),
                              min: 0,
                              max: maxSeconds,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white24,
                              onChanged: (newValue) {
                                setState(() {
                                  _isScrubbing = true;
                                  _scrubPosition = Duration(
                                    milliseconds: (newValue * 1000).round(),
                                  );
                                });
                              },
                              onChangeEnd: (newValue) async {
                                final target = Duration(
                                  milliseconds: (newValue * 1000).round(),
                                );
                                await _controller!.seekTo(target);
                                if (!mounted) return;
                                setState(() {
                                  _isScrubbing = false;
                                  _scrubPosition = target;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: [
                                Text(
                                  _formatDuration(position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  _formatDuration(duration),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
