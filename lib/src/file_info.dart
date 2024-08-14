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
class _DefaultFileInfo extends FileInfo {
}
