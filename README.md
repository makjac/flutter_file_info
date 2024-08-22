![header](https://i.imgur.com/5uioqZd.png)

[![Flutter Windows Tests](https://github.com/makjac/flutter_file_info/actions/workflows/windows.yml/badge.svg)](https://github.com/makjac/flutter_file_info/actions/workflows/windows.yml)

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
    pritn(fileMetadata.fileName);                    // Output: file.txt
    pritn(fileMetadata.fileExtension);               // Output: txt
    pritn(fileMetadata.fileType);                    // Output: TextDocument
    pritn(fileMetadata.creationTime?.toString());    // Output: 2024-08-01 17:16:26.500018
    // ...
}
```

## Screenshots

### Windows

![windows_example](https://i.imgur.com/Yo0GhFM.gif)

### Android

![android_example](https://i.imgur.com/EKQ3WDK.gif)

## Contributing

If you would like to contribute to the development of this plugin, please fork the repository and submit a pull request. For detailed contribution guidelines, please refer to the CONTRIBUTING.md file.

## License

This plugin is licensed under the [MIT License](https://github.com/makjac/flutter_file_info/blob/main/LICENSE).
