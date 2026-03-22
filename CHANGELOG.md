# 2.0.0

- Added mixed image and video support in grid layouts and fullscreen viewer.
- Added `ImageModel.video(...)` for video items.
- Added `autoPlay` to `MultiImageViewer` with a default value of `true`.
- Added fullscreen video playback controls including play/pause, mute, elapsed time, total duration, and draggable seek bar.
- Added zoomable fullscreen video presentation using `PhotoView.customChild`.
- Added shimmer placeholders for loading network images.
- Added video badges for video tiles in grid layouts.
- Added save support for both images and videos.
- Fixed `enableSave` so the fullscreen save button now respects the parameter.
- Fixed local save capture by attaching a valid repaint boundary.
- Added network video cache warm-up and cached replay support for faster repeat playback.
- Added internal helpers for temporary media file handling and video caching.

# 1.0.0

- Fixed `use_build_context_synchronously` lint by checking `context.mounted`.
- Updated `Color.withOpacity` to `Color.withValues` for Flutter 3.27 compatibility.
- Updated Dependencies

## 0.1.2

- Updated dependencies

## 0.1.1

- Used CachedNetworkImage instead of NetworkImage for better performance and caching images

## 0.1.0

- Optimized code for maximum pub points

## 0.0.9

- Added `networkImageHeaders` parameter to allow for custom headers to be passed to the network image

## 0.0.8

- Changed the process of listing images and captions by introducing List\<ImageModel>
- Captions are now fully optional

## 0.0.7

- Optimized code for maximum pub points

## 0.0.6

- Added download image feature
- Updated Dependencies

## 0.0.5

- Optimized code for maximum pub points

## 0.0.3

- Made height and width parameters dynamic
- Added Caption feature
- Updates to README
- Added a CHANGELOG

## 0.0.2

- Minor Fixes

## 0.0.1

- Initial public release
