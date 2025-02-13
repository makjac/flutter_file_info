import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/macos/macos_method_channel.dart';

/// Represents a file information specific to MacOS platform.
class FileInfoMacOS extends FileInfo {
  FileInfoMacOS({MacOSMethodChannel? macosMethodChannel})
      : _macosMethodChannel = macosMethodChannel ?? MacOSMethodChannelImpl();

  final MacOSMethodChannel _macosMethodChannel;

  static void registerWith() {
    FileInfo.instance = FileInfoMacOS();
  }

  @override
  Future<IconInfo?> getFileIconInfo(String filePath) async {
    return await _macosMethodChannel.getFileIcon(filePath);
  }

  @override
  Future<FileMetadata?> getFileInfo(String filePath) async {
    return await _macosMethodChannel.getFileInfo(filePath);
  }
}
