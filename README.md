![header][header_image_url]

[![Flutter Windows Tests][ci_badge]][ci_badge_link]
[![pub package][pub_badge]][pub_badge_link]
[![pub likes][pub_likes_badge]][pub_likes_link]
[![License: MIT][license_badge]][license_badge_link]

# flutter_file_info

A Flutter plugin for retrieving detailed file metadata, including system-native file icons. You can retrieve the native icon assigned to a file based on its type, ensuring a consistent visual representation across platforms. Perfect for applications that require access to file details and icons.

## Features

* Access to native file icons.
* Retrieval of detailed file metadata.

## Compatibility Chart

| API                   | Android            | iOS                | Linux              | macOS              | Windows            | Web                |
| --------------------- | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| getFileIconInfo()     | :heavy_check_mark: | :heavy_check_mark: | :x:                | :heavy_check_mark: | :heavy_check_mark: | :x:                |
| getFileInfo()         | :heavy_check_mark: | :heavy_check_mark: | :x:                | :heavy_check_mark: | :heavy_check_mark: | :x:                |

## iOS Deployment Target

This plugin requires a minimum iOS deployment target of 13.0.
Ensure that your project is configured correctly by following these steps:

  1. **Update the `Podfile`**

      In the `ios/Podfile` file, set the deployment target:

      ```podfile
      platform :ios, '13.0'
      ```

      After making this change, run:

      ```bash
      cd ios && pod install
      ```

  2. **Update Xcode Project Settings**

      1. Open your project in Xcode (ios/Runner.xcworkspace).
      2. Navigate to Runner → General.
      3. In the Deployment Info section, set iOS Deployment Target to 13.0.

  These steps ensure that your project is compatible with the required iOS version.

## Getting Started

### Usage

Quick simple usage example:

#### Get icon info

```dart
IconInfo? iconInfo = await FileInfo.instance.getFileIconInfo('path/to/example/file.txt');

Widget _buildFileIcon() {
    if (iconInfo == null) return const SizedBox.shrink();
    return Image.memory(
      iconInfo!.pixelData,
      width: iconInfo!.width.toDouble(),
      height: iconInfo!.height.toDouble(),
    );
  }
```

#### Get file info

```dart
FileMetadata? fileMetadata = await FileInfo.instance.getFileInfo('path/to/example/file.txt');

if (fileMetadata != null) {
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

### MacOS

![macos_example][macos_example_url]

### iOS

![ios_example][ios_example_url]

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

[header_image_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/flutter_file_info/flutter_file_info_banner.png
[windows_example_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/flutter_file_info/file_info_win.gif
[macos_example_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/flutter_file_info/macos_flutter_file_info.gif
[android_example_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/flutter_file_info/flutter_file_info_android.gif
[ios_example_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/flutter_file_info/ios_flutter_file_info.gif
