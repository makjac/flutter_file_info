import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FileInfo extends PlatformInterface {
  FileInfo() : super(token: _token);

  static final Object _token = Object();

  static FileInfo _instance = _DefaultFileInfo();

  static FileInfo get instance => _instance;

  static set instance(FileInfo instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Retrieves the icon information for a file or directory specified by [filePath].
  ///
  /// This method provides detailed information about the icon associated with
  /// the file or directory, including the icon's dimensions, color depth, and
  /// pixel data. The pixel data is encoded in PNG format.
  ///
  /// The [filePath] parameter should be a valid path to the file or directory
  /// whose icon information is to be retrieved.
  ///
  /// Returns an [IconInfo] object containing details about the file's icon.
  /// If the icon information cannot be retrieved, the method returns `null`.
  ///
  /// Throws an [UnimplementedError] if this method is not yet implemented.
  ///
  /// Example:
  /// ```dart
  /// final iconInfo = await fileInfoWindows.getFileIconInfo('C:\\path\\to\\file.txt');
  /// if (iconInfo != null) {
  ///   print('Icon width: ${iconInfo.width}');
  ///   print('Icon height: ${iconInfo.height}');
  /// }
  /// ```
  Future<IconInfo?> getFileIconInfo(String filePath) =>
      throw UnimplementedError('getFileIconInfo() has not been implemented.');
  Future<FileMetadata?> getFileInfo(String filePath) =>
      throw UnimplementedError('getFileInfo() has not been implemented.');
}

class _DefaultFileInfo extends FileInfo {
  @override
  Future<IconInfo?> getFileIconInfo(String filePath) {
    throw UnimplementedError(
        'Platform interface has not been implemented for this platform.');
  }

  @override
  Future<FileMetadata?> getFileInfo(String filePath) {
    throw UnimplementedError(
        'Platform interface has not been implemented for this platform.');
  }
}
