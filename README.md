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

Experience dynamic image layout capabilities with this Flutter package.
Effortlessly integrate single or multiple images and observe the adaptive layout transformation in real-time.
Enhanced with caption support for each image, it offers both versatility and precision for developers keen on superior UI experiences.

![Screenshot_1656283282](https://user-images.githubusercontent.com/45544067/175837492-d73e2493-64d4-402d-aa98-1e87ddb70942.png)

![Screenshot_1656283292](https://user-images.githubusercontent.com/45544067/175837509-accf5250-e616-46df-979a-ae0f4ea85133.png)

## Getting started

```dart
import 'package:multi_image_layout/multi_image_viewer.dart';
```

### iOS

Add the following keys to your Info.plist file, located in `<project root>/ios/Runner/Info.plist`:

* `NSPhotoLibraryAddUsageDescription` - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.

### Android

You need to ask for storage permission to save an image to the gallery. You can handle the storage permission using [flutter_permission_handler](https://pub.dev/packages/permission_handler) package.

* `android.permission.WRITE_EXTERNAL_STORAGE` - Permission for usage of external storage

```xml
<application android:requestLegacyExternalStorage="true" .....>
```

## Usage

```dart
import 'package:multi_image_layout/multi_image_viewer.dart';
MultiImageViewer(
  images: [
    ImageModel(
      imageUrl: "https://4.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4684313123.jpg",
      caption: "Caption 1",
    ),
    ImageModel(
      imageUrl: "https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg",
      caption: "Caption 2",
    ),
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
