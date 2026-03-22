class ImageModel {
  const ImageModel({
    required this.imageUrl,
    this.caption,
  }) : videoUrl = null;

  const ImageModel.video({
    required String this.videoUrl,
    this.caption,
  }) : imageUrl = videoUrl;

  final String imageUrl;
  final String? videoUrl;
  final String? caption;

  bool get isVideo => videoUrl != null;

  String get sourceUrl => videoUrl ?? imageUrl;
}
