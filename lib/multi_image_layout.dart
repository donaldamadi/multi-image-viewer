library multi_image_layout;

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';

class MultiImageViewer extends StatelessWidget {
  const MultiImageViewer({
    Key? key,
    required this.images,
    this.captions,
    this.backgroundColor = Colors.black87,
    this.textStyle = const TextStyle(
      fontSize: 30,
    ),
    this.height = 205,
    this.width,
  }) : super(key: key);

  /// Color of the background image.
  final Color backgroundColor;

  ///Color for the textStyle
  final TextStyle textStyle;

  /// List of network images to display.
  final List<String> images;

  /// List of captions to display.
  ///
  /// Each caption is displayed with respect to its corresponding image.
  ///
  /// The number of captions `must` be equal to the number of images or else, captions will not be displayed.
  final List<String>? captions;

  /// Height of the image(s).
  ///
  /// If not set, it will be a height of 205.0.
  final double height;

  /// Width of the image(s).
  final double? width;

  @override
  Widget build(BuildContext context) {
    /// MediaQuery Width
    double defaultWidth = MediaQuery.of(context).size.width;

    if (images.isEmpty) {
      return Container();
    }
    if (images.length == 1) {
      return GestureDetector(
        onTap: () => openImage(context, 0, images, captions),
        child: Container(
          height: height,
          width: width ?? defaultWidth,
          decoration: BoxDecoration(
            color: backgroundColor,
            image: DecorationImage(
                image: NetworkImage(images[0]), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      );
    } else if (images.length == 2) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 1),
              child: GestureDetector(
                onTap: () => openImage(context, 0, images, captions),
                child: Container(
                  height: height,
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                          image: NetworkImage(images[0]), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: GestureDetector(
                onTap: () => openImage(context, 1, images, captions),
                child: Container(
                  height: height,
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                          image: NetworkImage(images[1]), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                ),
              ),
            ),
          ),
        ]),
      );
    } else if (images.length == 3) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 0, images, captions),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[0]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[1]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () => openImage(context, 2, images, captions),
                child: Container(
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                          image: NetworkImage(images[2]), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                ),
              ),
            ),
          ),
        ]),
      );
    } else if (images.length == 4) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 0, images, captions),
                      child: Container(
                        // width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[0]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[1]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 2, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[2]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 0),
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[3]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    } else if (images.length > 4) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 0, images, captions),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: NetworkImage(images[0]),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: NetworkImage(images[1]),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 2),
                    child: GestureDetector(
                      onTap: () => openImage(context, 2, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: NetworkImage(images[2]),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 0),
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: NetworkImage(images[3]),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                              child: Text("+${images.length - 4}",
                                  style: textStyle)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    } else {
      return const SizedBox();
    }
  }
}

/// View Image(s)
void openImage(BuildContext context, final int index, List<String> unitImages,
    List<String>? captions) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        galleryItems: unitImages,
        captions: captions,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}

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
    if (widget.captions != null &&
        widget.captions!.length == widget.galleryItems!.length) {
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
      imageProvider: NetworkImage(item),
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
          alignment:
              showCaptions ? Alignment.bottomCenter : Alignment.bottomRight,
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
                      moreStyle: const TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
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
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 15,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    debugPrint(widget.galleryItems![currentIndex!]);
                    final status = await GallerySaver.saveImage(
                        widget.galleryItems![currentIndex!]);
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
