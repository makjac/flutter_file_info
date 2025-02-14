import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/ios/ios_method_channel.dart';

/// Represents a file information specific to iOS platform.
class FileInfoIOS extends FileInfo {
  FileInfoIOS({IOSMethodChannel? iOSMethodChannel})
      : _iOSMethodChannel = iOSMethodChannel ?? IOSMethodChannelImpl();

  final IOSMethodChannel _iOSMethodChannel;

  static void registerWith() {
    FileInfo.instance = FileInfoIOS();
  }

  @override
  Future<IconInfo?> getFileIconInfo(String filePath) async {
    return await _iOSMethodChannel.getFileIcon(filePath);
  }

  @override
  Future<FileMetadata?> getFileInfo(String filePath) async {
    return await _iOSMethodChannel.getFileInfo(filePath);
  }
}
