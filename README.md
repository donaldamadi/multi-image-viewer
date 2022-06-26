<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
## Description

This package tries to give a twitter-like layout to images. Simply add one or more images and watch the layout change.
Captions can also be added to each image.


![Screenshot_1652982814](https://user-images.githubusercontent.com/45544067/169372606-80aba81c-a8a2-406c-8112-347cf0eaac46.png)

![Screenshot_1652982828](https://user-images.githubusercontent.com/45544067/169372676-f12edce6-8852-4c6d-a19c-9d672dc472f3.png)


## Getting started

```dart
import 'package:multi_image_layout/multi_image_viewer.dart';
```

## Usage

```dart
import 'package:multi_image_layout/multi_image_viewer.dart';
MultiImageViewer(
  images: [
    "https://picsum.photos/id/1/200/300",
    "https://picsum.photos/id/2/200/300",
    "https://picsum.photos/id/3/200/300",
  ],
  captions: [
    "Caption 1",
    "Caption 2",
    "Caption 3",
  ],
  height: 200,
  width: 200,
 ),
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a 👍 if you like this project!


## 📝 License

This project is [MIT](./LICENSE) licensed.
