import 'src/video_cache_helper_stub.dart'
    if (dart.library.io) 'src/video_cache_helper_io.dart' as video_cache_helper;
import 'multi_image_layout.dart';

class MultiImageViewer extends StatelessWidget {
  const MultiImageViewer({
    super.key,
    required this.images,
    this.backgroundColor = Colors.black87,
    this.textStyle = const TextStyle(
      fontSize: 30,
      color: Colors.white,
    ),
    this.height = 216,
    this.width,
    this.networkImageHeaders,
    this.enableSave = true,
    this.autoPlay = true,
    this.gap = 2,
    this.radius = const Radius.circular(5),
  });

  /// Headers for network image and video requests.
  final Map<String, String>? networkImageHeaders;

  /// Color of the background image.
  final Color backgroundColor;

  ///Color for the textStyle
  final TextStyle textStyle;

  /// ```List<ImageModel>``` of media and captions to display.
  final List<ImageModel> images;

  /// Height of the image(s).
  final double height;

  /// Width of the image(s).
  final double? width;

  /// Responsible for displaying download icon button
  final bool enableSave;

  /// Responsible for auto playing videos.
  final bool autoPlay;

  /// Gap between Images in px
  final double gap;

  /// Border Radius for edge corners
  final Radius radius;

  Widget _buildMediaSurface(
    ImageModel media,
    BorderRadius borderRadius, {
    Widget? overlay,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),
          Positioned.fill(
            child: media.isVideo
                ? _VideoTileSurface(
                    media: media,
                    headers: networkImageHeaders,
                    autoPlay: autoPlay,
                  )
                : _ImageTileSurface(
                    media: media,
                    headers: networkImageHeaders,
                  ),
          ),
          if (media.isVideo)
            const Positioned(
              top: 10,
              right: 10,
              child: _VideoBadge(),
            ),
          if (overlay != null) Positioned.fill(child: overlay),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    int index,
    BorderRadius borderRadius, {
    double? tileWidth,
    double? tileHeight,
    Widget? overlay,
  }) {
    return GestureDetector(
      onTap: () => openImage(
        context,
        index,
        images,
        networkImageHeaders,
        enableSave,
        autoPlay,
      ),
      child: SizedBox(
        width: tileWidth,
        height: tileHeight,
        child: _buildMediaSurface(
          images[index],
          borderRadius,
          overlay: overlay,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double defaultWidth = MediaQuery.sizeOf(context).width;

    switch (images.length) {
      case 0:
        return const SizedBox.shrink();

      case 1:
        return _buildTile(
          context,
          0,
          BorderRadius.all(radius),
          tileWidth: width ?? defaultWidth,
          tileHeight: height,
        );

      case 2:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(
            children: [
              Expanded(
                child: _buildTile(
                  context,
                  0,
                  BorderRadius.only(topLeft: radius, bottomLeft: radius),
                  tileHeight: height,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _buildTile(
                  context,
                  1,
                  BorderRadius.only(topRight: radius, bottomRight: radius),
                  tileHeight: height,
                ),
              ),
            ],
          ),
        );

      case 3:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(
            children: [
              Expanded(
                child: _buildTile(
                  context,
                  0,
                  BorderRadius.only(topLeft: radius, bottomLeft: radius),
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildTile(
                        context,
                        1,
                        BorderRadius.only(topRight: radius),
                      ),
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: _buildTile(
                        context,
                        2,
                        BorderRadius.only(bottomRight: radius),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 4:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildTile(
                        context,
                        0,
                        BorderRadius.only(topLeft: radius),
                      ),
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: _buildTile(
                        context,
                        2,
                        BorderRadius.only(bottomLeft: radius),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildTile(
                        context,
                        1,
                        BorderRadius.only(topRight: radius),
                      ),
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: _buildTile(
                        context,
                        3,
                        BorderRadius.only(bottomRight: radius),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      default:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildTile(
                        context,
                        0,
                        BorderRadius.only(topLeft: radius),
                      ),
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: _buildTile(
                        context,
                        2,
                        BorderRadius.only(bottomLeft: radius),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildTile(
                        context,
                        1,
                        BorderRadius.only(topRight: radius),
                      ),
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: _buildTile(
                        context,
                        3,
                        BorderRadius.only(bottomRight: radius),
                        overlay: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.only(
                              bottomRight: radius,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "+${images.length - 4}",
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }
}

class _ImageTileSurface extends StatelessWidget {
  const _ImageTileSurface({
    required this.media,
    required this.headers,
  });

  final ImageModel media;
  final Map<String, String>? headers;

  bool get _isNetworkSource =>
      media.sourceUrl.startsWith('http://') ||
      media.sourceUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (_isNetworkSource) {
      return CachedNetworkImage(
        imageUrl: media.sourceUrl,
        httpHeaders: headers,
        fit: BoxFit.cover,
        placeholder: (_, __) => const _ShimmerPlaceholder(),
        errorWidget: (_, __, ___) => const _ImageErrorPlaceholder(),
      );
    }

    return Image.asset(
      media.sourceUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const _ImageErrorPlaceholder(),
    );
  }
}

class _VideoTileSurface extends StatefulWidget {
  const _VideoTileSurface({
    required this.media,
    required this.headers,
    required this.autoPlay,
  });

  final ImageModel media;
  final Map<String, String>? headers;
  final bool autoPlay;

  @override
  State<_VideoTileSurface> createState() => _VideoTileSurfaceState();
}

class _VideoTileSurfaceState extends State<_VideoTileSurface> {
  VideoPlayerController? _controller;
  bool _isReady = false;
  bool _hasError = false;

  bool get _isNetworkSource =>
      widget.media.sourceUrl.startsWith('http://') ||
      widget.media.sourceUrl.startsWith('https://');

  @override
  void initState() {
    super.initState();
    if (_isNetworkSource) {
      video_cache_helper.warmNetworkVideoCache(
        widget.media.sourceUrl,
        headers: widget.headers,
      );
    }
    _initializeController();
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
          widget.media.sourceUrl,
          headers: widget.headers,
        );
      } else {
        controller = VideoPlayerController.asset(widget.media.sourceUrl);
      }

      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      if (widget.autoPlay) {
        await controller.play();
      }

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
        _isReady = true;
        _hasError = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const _ImageErrorPlaceholder();
    }

    if (!_isReady || _controller == null || !_controller!.value.isInitialized) {
      return const _ShimmerPlaceholder();
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller!.value.size.width,
        height: _controller!.value.size.height,
        child: VideoPlayer(_controller!),
      ),
    );
  }
}

class _VideoBadge extends StatelessWidget {
  const _VideoBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class _ShimmerPlaceholder extends StatefulWidget {
  const _ShimmerPlaceholder();

  @override
  State<_ShimmerPlaceholder> createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<_ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        key: const ValueKey('multi_image_viewer_shimmer'),
        color: const Color(0xFF1E1E1E),
      ),
      builder: (context, child) {
        final slide = (_controller.value * 2) - 1;
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - slide, -0.3),
              end: Alignment(1.0 - slide, 0.3),
              colors: const [
                Color(0xFF3A3A3A),
                Color(0xFFBDBDBD),
                Color(0xFF3A3A3A),
              ],
              stops: const [0.1, 0.45, 0.8],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
    );
  }
}

class _ImageErrorPlaceholder extends StatelessWidget {
  const _ImageErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF1E1E1E),
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white54,
          size: 28,
        ),
      ),
    );
  }
}
