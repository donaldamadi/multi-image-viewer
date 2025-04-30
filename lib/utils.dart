import 'multi_image_layout.dart';

/// View Image(s)
void openImage(BuildContext context, final int index, List<String> unitImages,
    List<String>? captions, Map<String, String>? headers, bool enableSave) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        enableSave: enableSave,
        galleryItems: unitImages,
        captions: captions,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
        headers: headers,
      ),
    ),
  );
}
