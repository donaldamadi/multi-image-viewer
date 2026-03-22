import 'package:flutter_test/flutter_test.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

void main() {
  test('ImageModel should hold imageUrl and caption correctly', () {
    final model = const ImageModel(imageUrl: 'testUrl', caption: 'testCaption');
    expect(model.imageUrl, 'testUrl');
    expect(model.sourceUrl, 'testUrl');
    expect(model.isVideo, isFalse);
    expect(model.caption, 'testCaption');
  });

  test('ImageModel.video should flag video content correctly', () {
    const model = ImageModel.video(
      videoUrl: 'https://example.com/video.mp4',
      caption: 'video caption',
    );

    expect(model.isVideo, isTrue);
    expect(model.sourceUrl, 'https://example.com/video.mp4');
    expect(model.caption, 'video caption');
  });
}
