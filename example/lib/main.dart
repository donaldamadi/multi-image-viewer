import 'package:multi_image_layout/multi_image_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Multi Image Layout Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Single(1) Image"),
              const SizedBox(height: 10),
              MultiImageViewer(images: [
                ImageModel(
                  imageUrl:
                      "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                  caption:
                      "Ut eu pariatur sit cupidatat ut sit enim do enim eiusmod officia enim consequat fugiat. Est amet tempor duis tempor sunt reprehenderit officia ut est cillum tempor. Cupidatat sunt nostrud laboris exercitation. Officia do eu consectetur officia velit in nulla ullamco qui elit laborum anim. Do dolore magna id adipisicing excepteur in qui. Irure quis pariatur amet in.",
                )
              ]),
              const SizedBox(height: 30),
              const Text("Two(2) Images"),
              const SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  ImageModel(
                    imageUrl:
                        "https://4.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4684313123.jpg",
                    caption: "Caption 1",
                  ),
                  ImageModel(
                    imageUrl:
                        "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                    caption: "Caption 2",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Three(3) Images"),
              const SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                      caption: "A caption here"),
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg",
                      caption: "Another caption here"),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Four(4) Images"),
              const SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://1.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/6294874831.jpg"),
                ],
              ),
              const SizedBox(height: 30),
              const Text("More than Four(4+) Images"),
              const SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  ImageModel(
                    imageUrl:
                        "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                    caption: "A caption here",
                  ),
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://1.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/6294874831.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg"),
                  ImageModel(
                      imageUrl:
                          "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg"),
                ],
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
