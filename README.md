![header][header_image_url]

[![Flutter Windows Tests][ci_badge]][ci_badge_link]
[![pub package][pub_badge]][pub_badge_link]
[![pub likes][pub_likes_badge]][pub_likes_link]
[![License: MIT][license_badge]][license_badge_link]

# flutter_file_info

A Flutter plugin for retrieving detailed file metadata, including native icons. Ideal for applications needing file information and icons.

## Currently supported features

* Access to native file icons.
* Retrieval of detailed file metadata.

## Compatibility Chart

| API                   | Android            | iOS                | Linux              | macOS              | Windows            | Web                |
| --------------------- | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| getFileIconInfo()     | :heavy_check_mark: | :x:                | :x:                | :x:                | :heavy_check_mark: | :x:                |
| getFileInfo()         | :heavy_check_mark: | :x:                | :x:                | :x:                | :heavy_check_mark: | :x:                |

## Getting Started

### Usage

Quick simple usage example:

#### Get icon info

```dart
IconInfo? _iconInfo = await FileInfo.instance.getFileIconInfo('path/to/example/file.txt');

Widget _buildFileIcon() {
    if (_iconInfo == null) return const SizedBox.shrink();
    return Image.memory(
      _iconInfo!.pixelData,
      width: _iconInfo!.width.toDouble(),
      height: _iconInfo!.height.toDouble(),
    );
  }
```

#### Fet file info

```dart
FileMetadata? _fileMetatdata = await FileInfo.instance.getFileInfo('path/to/example/file.txt');

if (_fileMetatdata != null) {
    print(fileMetadata.fileName);                    // Output: file.txt
    print(fileMetadata.fileExtension);               // Output: txt
    print(fileMetadata.fileType);                    // Output: TextDocument
    print(fileMetadata.creationTime?.toString());    // Output: 2024-08-01 17:16:26.500018
    // ...
}
```

## Screenshots

### Windows

![windows_example][windows_example_url]

### Android

![android_example][android_example_url]

## Contributing

If you would like to contribute to the development of this plugin, please fork the repository and submit a pull request. For detailed contribution guidelines, please refer to the CONTRIBUTING.md file.

## License

This plugin is licensed under the [MIT License][mit_license_url].


<!-- end:excluded_rules_table -->

[ci_badge]: https://github.com/VeryGoodOpenSource/very_good_analysis/workflows/ci/badge.svg
[ci_badge_link]: https://github.com/makjac/flutter_file_info/actions/workflows/windows.yml

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT

[pub_likes_badge]: https://img.shields.io/pub/likes/flutter_file_info
[pub_likes_link]: https://pub.dev/packages/flutter_file_info

[pub_badge]: https://img.shields.io/pub/v/flutter_file_info.svg
[pub_badge_link]: https://pub.dev/packages/flutter_file_info

[mit_license_url]: https://github.com/makjac/flutter_file_info/blob/main/LICENSE

[header_image_url]: https://i.imgur.com/5uioqZd.png
[windows_example_url]: https://i.imgur.com/Yo0GhFM.gif
[android_example_url]: https://i.imgur.com/EKQ3WDK.gif
