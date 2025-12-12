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
    this.gap = 2,
    this.radius = const Radius.circular(5),
  });

  /// Headers for network image
  final Map<String, String>? networkImageHeaders;

  /// Color of the background image.
  final Color backgroundColor;

  ///Color for the textStyle
  final TextStyle textStyle;

  /// ```List<ImageModel>``` of images and captions to display.
  ///
  /// Each image is displayed with respect to its corresponding caption.
  ///
  /// Images are compulsory while captions are optional.
  final List<ImageModel> images;

  /// Height of the image(s).
  ///
  /// If not set, it will be a height of 205.0.
  final double height;

  /// Width of the image(s).
  final double? width;

  /// Responsible for displaying download icon button
  final bool enableSave;

  /// Gap between Images in px
  final double gap;

  /// Border Radius for edge corners
  final Radius radius;

  CachedNetworkImageProvider _createNetworkImage(String path) =>
      CachedNetworkImageProvider(path, headers: networkImageHeaders);

  @override
  Widget build(BuildContext context) {
    /// MediaQuery Width
    double defaultWidth = MediaQuery.sizeOf(context).width;
    final imagesList = images.map((image) => image.imageUrl).toList();
    final captionList = images
            .any((image) => image.caption != null && image.caption!.isNotEmpty)
        ? images.map((image) => image.caption ?? '').toList()
        : null;

    switch (images.length) {
      case 0:
        return const SizedBox.shrink();

      case 1:
        return GestureDetector(
          onTap: () => openImage(context, 0, imagesList, captionList,
              networkImageHeaders, enableSave),
          child: Container(
            height: height,
            width: width ?? defaultWidth,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: DecorationImage(
                image: _createNetworkImage(images.first.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(radius),
            ),
          ),
        );

      case 2:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () => openImage(context, 0, imagesList, captionList,
                    networkImageHeaders, enableSave),
                child: Container(
                  height: height,
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: DecorationImage(
                        image: _createNetworkImage(images.first.imageUrl),
                        fit: BoxFit.cover),
                    borderRadius:
                        BorderRadius.only(topLeft: radius, bottomLeft: radius),
                  ),
                ),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: GestureDetector(
                onTap: () => openImage(context, 1, imagesList, captionList,
                    networkImageHeaders, enableSave),
                child: Container(
                  height: height,
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: DecorationImage(
                        image: _createNetworkImage(images[1].imageUrl),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topRight: radius, bottomRight: radius),
                  ),
                ),
              ),
            ),
          ]),
        );

      case 3:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () => openImage(context, 0, imagesList, captionList,
                    networkImageHeaders, enableSave),
                child: Container(
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: DecorationImage(
                        image: _createNetworkImage(images.first.imageUrl),
                        fit: BoxFit.cover),
                    borderRadius:
                        BorderRadius.only(topLeft: radius, bottomLeft: radius),
                  ),
                ),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: _createNetworkImage(images[1].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(topRight: radius),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 2, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: _createNetworkImage(images[2].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(bottomRight: radius),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      case 4:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 0, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        // width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image:
                                    _createNetworkImage(images.first.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(topLeft: radius)),
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 2, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[2].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.only(bottomLeft: radius)),
                      ),
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
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[1].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(topRight: radius)),
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[3].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.only(bottomRight: radius)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );

      default:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 0, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image:
                                    _createNetworkImage(images.first.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(topLeft: radius)),
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 2, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: _createNetworkImage(images[2].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            bottomLeft: radius,
                          ),
                        ),
                      ),
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
                    child: GestureDetector(
                      onTap: () => openImage(context, 1, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: _createNetworkImage(images[1].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            topRight: radius,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, imagesList,
                          captionList, networkImageHeaders, enableSave),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                              image: _createNetworkImage(images[3].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            bottomRight: radius,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.only(
                              bottomRight: radius,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
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
    }
  }
}
