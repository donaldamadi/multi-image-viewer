import 'package:flutter_test/flutter_test.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

void main() {
  test('ImageModel should hold imageUrl and caption correctly', () {
    final model = ImageModel(imageUrl: 'testUrl', caption: 'testCaption');
    expect(model.imageUrl, 'testUrl');
    expect(model.caption, 'testCaption');
  });
}
