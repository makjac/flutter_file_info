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
