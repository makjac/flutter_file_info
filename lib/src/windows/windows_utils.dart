import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/src/windows/enum/file_attribiutes.dart';
import 'package:win32/win32.dart';

abstract class WindowsUtils {
  String getFileType(String filePath);
  DateTime convertFileTimeToDateTime(FILETIME fileTime);
  List<FileAttributes> getFileAttributesFromMask(int attributeMask);
  String formatFileSize(int sizeInBytes);
}
