## 0.0.1

* Initial Release: Created the flutter_file_info plugin.
* Platform Support: Initial release supports only Windows.
* getFileInfo: Retrieves detailed metadata about a file specified by [filePath].
* getFileIconInfo: Retrieves icon information for a file or directory specified by [filePath].

## 0.0.2

* fix: fix headers in code example sections

## 0.1.0

* feat: Support for Android platform. Methods `getFileInfo` and `getFileIconInfo` now work on Android
* feat: `AndroidFileAttributes` enum for Android-specific file permissions
* refactor: Renamed `attributes` to `winAttributes` in `FileMetadata`
* feat: Added `androidAttributes` for Android-specific attributes in `FileMetadata`
