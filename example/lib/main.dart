import 'package:flutter/material.dart';
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
            children: const [
              Text("Single(1) Image"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                ],
                captions: [
                  "Writing a very long text to check if the feature works as expected. This is a caption for the image. I hope it works as expected.",
                ],
              ),
              SizedBox(height: 30),
              Text("Two(2) Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://4.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4684313123.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                ],
                captions: [
                  "Writing a very long text to check if the feature works as expected. This is a caption for the image. I hope it works as expected.",
                  "Caption 2",
                ],
              ),
              SizedBox(height: 30),
              Text("Three(3) Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                  "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg",
                ],
              ),
              SizedBox(height: 30),
              Text("Four(4) Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                  "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg",
                  "https://1.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/6294874831.jpg"
                ],
              ),
              SizedBox(height: 30),
              Text("More than Four(4+) Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                  "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg",
                  "https://1.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/6294874831.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
                  "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4086993630.jpg",
                  "https://2.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/5713335642.jpg",
                ],
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
