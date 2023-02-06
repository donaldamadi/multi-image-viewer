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
# Description

This package gives a twitter-like layout to images. Simply add one or more images and watch the layout change.
Captions can also be added to each image.

![Screenshot_1656283282](https://user-images.githubusercontent.com/45544067/175837492-d73e2493-64d4-402d-aa98-1e87ddb70942.png)

![Screenshot_1656283292](https://user-images.githubusercontent.com/45544067/175837509-accf5250-e616-46df-979a-ae0f4ea85133.png)

## Getting started

```dart
import 'package:multi_image_layout/multi_image_viewer.dart';
```

### iOS

Add the following keys to your Info.plist file, located in `<project root>/ios/Runner/Info.plist`:

* `NSPhotoLibraryUsageDescription` - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.

### Android

* `android.permission.WRITE_EXTERNAL_STORAGE` - Permission for usage of external storage

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
