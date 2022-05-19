import 'package:flutter/material.dart';
import 'package:multi_image_viewer/multi_image_viewer.dart';

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
      home: const MyHomePage(title: 'Flutter Example'),
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
              Text("Single Image"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://picsum.photos/id/1/200/300",
                ],
              ),
              SizedBox(height: 30),
              Text("Two Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://picsum.photos/id/1/200/300",
                  "https://picsum.photos/id/2/200/300",
                ],
              ),
              SizedBox(height: 30),
              Text("Three Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://picsum.photos/id/1/200/300",
                  "https://picsum.photos/id/2/200/300",
                  "https://picsum.photos/id/3/200/300",
                ],
              ),
              SizedBox(height: 30),
              Text("Four Images"),
              SizedBox(height: 10),
              MultiImageViewer(
                images: [
                  "https://picsum.photos/id/1/200/300",
                  "https://picsum.photos/id/2/200/300",
                  "https://picsum.photos/id/3/200/300",
                  "https://picsum.photos/id/4/200/300"
                ],
              ),
              SizedBox(height: 30),
              Text("More than Four Images"),
              SizedBox(height: 10),
              MultiImageViewer(images: [
                "https://picsum.photos/id/1/200/300",
                "https://picsum.photos/id/2/200/300",
                "https://picsum.photos/id/3/200/300",
                "https://picsum.photos/id/4/200/300",
                "https://picsum.photos/id/5/200/300",
              ]),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
