import 'multi_image_layout.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    required this.galleryItems,
    this.captions,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex!),
        super(key: key);

  final BoxDecoration? backgroundDecoration;
  final List<String>? galleryItems;
  final List<String>? captions;
  final int? initialIndex;
  final LoadingBuilder? loadingBuilder;
  final dynamic maxScale;
  final dynamic minScale;
  final PageController pageController;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int? currentIndex;
  bool showCaptions = false;

  @override
  void initState() {
    checkCaptionLength();
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void checkCaptionLength() {
    if (widget.captions != null && widget.captions!.length == widget.galleryItems!.length) {
      showCaptions = true;
    }
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: item.contains('http') ? NetworkImage(item) : AssetImage(item) as ImageProvider<Object>,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          alignment: showCaptions ? Alignment.bottomCenter : Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration ??
                  const BoxDecoration(
                    color: Color.fromARGB(255, 9, 40, 1),
                  ),
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: showCaptions
                  ? ReadMoreText(
                      widget.captions![currentIndex!],
                      trimLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      colorClickableText: Colors.white,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Image ${currentIndex! + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        decoration: null,
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
            Positioned(
              top: 80,
              right: 15,
              child: IconButton(
                color: Colors.white,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.download),
                onPressed: () async {
                  debugPrint(widget.galleryItems![currentIndex!]);
                  final status = await GallerySaver.saveImage(widget.galleryItems![currentIndex!]);
                  if (status == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Image saved to gallery"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error saving image"),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
