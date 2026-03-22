import 'multi_image_layout.dart';

/// View media item(s)
void openImage(
  BuildContext context,
  int index,
  List<ImageModel> mediaItems,
  Map<String, String>? headers,
  bool enableSave,
  bool autoPlay,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        enableSave: enableSave,
        mediaItems: mediaItems,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
        headers: headers,
        autoPlay: autoPlay,
      ),
    ),
  );
}
