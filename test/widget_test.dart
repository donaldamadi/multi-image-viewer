import 'package:flutter_test/flutter_test.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

void main() {
  testWidgets('MultiImageViewer shows shimmer while network image loads',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MultiImageViewer(
            images: [
              ImageModel(
                imageUrl: 'https://example.com/image.jpg',
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('multi_image_viewer_shimmer')), findsOne);
  });

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
