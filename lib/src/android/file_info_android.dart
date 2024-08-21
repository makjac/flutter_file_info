import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/android/android_method_channel.dart';

/// Represents a file information specific to Android platform.
class FileInfoAndroid extends FileInfo {
  FileInfoAndroid({AndroidMethodChannel? androidMethodChannel})
      : _androidMethodChannel =
            androidMethodChannel ?? AndroidMethodChannelImpl();

  final AndroidMethodChannel _androidMethodChannel;

  static void registerWith() {
    FileInfo.instance = FileInfoAndroid();
  }

  @override
  Future<IconInfo?> getFileIconInfo(String filePath) async {
    return await _androidMethodChannel.getFileIcon(filePath);
  }

  @override
  Future<FileMetadata?> getFileInfo(String filePath) =>
      throw UnimplementedError('getFileInfo() has not been implemented.');
}
