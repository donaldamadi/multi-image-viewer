import 'package:flutter_test/flutter_test.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

void main() {
  testWidgets('GalleryPhotoViewWrapper displays image and caption',
      (WidgetTester tester) async {
    const mockImageUrl = 'assets/images/simple_image.jpeg';
    await tester.pumpWidget(MaterialApp(
      home: GalleryPhotoViewWrapper(
        galleryItems: const [mockImageUrl],
        captions: const ['Test caption'],
        initialIndex: 0,
      ),
    ));

    expect(find.byType(PhotoViewGallery), findsOneWidget);
    expect(find.text('Test caption'), findsOneWidget);
  });
}
